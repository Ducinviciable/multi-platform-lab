import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController cityController = TextEditingController();
  final FocusNode _cityFocusNode = FocusNode();

  Timer? _debounce;
  List<String> _citySuggestions = [];

  String cityName = "";
  String temp = "";
  String desc = "";
  String iconUrl = "";
  bool isLoading = false;

  @override
  void dispose() {
    _debounce?.cancel();
    cityController.dispose();
    _cityFocusNode.dispose();
    super.dispose();
  }

  String _removeVietnameseDiacritics(String input) {
    const withDiacritics =
        "àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ"
        "ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ";
    const withoutDiacritics =
        "aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd"
        "AAAAAAAAAAAAAAAAAEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYD";

    final buffer = StringBuffer();
    for (final char in input.split('')) {
      final index = withDiacritics.indexOf(char);
      buffer.write(index >= 0 ? withoutDiacritics[index] : char);
    }
    return buffer.toString();
  }

  void _onCityChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      _fetchCitySuggestions(value);
    });
  }

  Future<void> _fetchCitySuggestions(String rawInput) async {
    final query = rawInput.trim();

    if (query.isEmpty) {
      if (!mounted) {
        return;
      }
      setState(() {
        _citySuggestions = [];
      });
      return;
    }

    const apiKey = "5e3eb113c28c4841bbe170805262504";
    final searchQueries = <String>[query];
    final normalizedQuery = _removeVietnameseDiacritics(query);
    if (normalizedQuery != query) {
      searchQueries.add(normalizedQuery);
    }

    final suggestionSet = <String>{};

    for (final search in searchQueries) {
      try {
        final url = Uri.https('api.weatherapi.com', '/v1/search.json', {
          'key': apiKey,
          'q': search,
        });

        final response = await http.get(url);
        if (response.statusCode != 200) {
          continue;
        }

        final data = jsonDecode(response.body);
        if (data is! List) {
          continue;
        }

        for (final item in data.take(8)) {
          final city = item['name'];
          final country = item['country'];
          if (city is String && country is String) {
            suggestionSet.add('$city, $country');
          }
        }
      } catch (_) {
        // Ignore autocomplete errors to keep typing responsive.
      }
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _citySuggestions = suggestionSet.take(10).toList();
    });
  }

  Future<void> getWeather() async {
    final city = cityController.text.trim();
    const apiKey = "5e3eb113c28c4841bbe170805262504";

    if (city.isEmpty) {
      setState(() {
        cityName = "Vui lòng nhập thành phố";
        temp = "";
        desc = "";
        iconUrl = "";
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.https('api.weatherapi.com', '/v1/current.json', {
        'key': apiKey,
        'q': city,
        'aqi': 'no',
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          cityName =
              "${data['location']['name']}, ${data['location']['country']}";
          temp = "${data['current']['temp_c']}°C";
          desc = data['current']['condition']['text'];
          iconUrl = "https:${data['current']['condition']['icon']}";
        });
      } else {
        cityName = "Không tìm thấy";
        temp = "";
        desc = "";
        iconUrl = "";
      }
    } catch (e) {
      cityName = "Lỗi mạng";
      temp = "";
      desc = "";
      iconUrl = "";
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            RawAutocomplete<String>(
              textEditingController: cityController,
              focusNode: _cityFocusNode,
              optionsBuilder: (TextEditingValue textEditingValue) {
                final query = textEditingValue.text.trim().toLowerCase();
                if (query.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return _citySuggestions.where(
                  (option) => option.toLowerCase().contains(query),
                );
              },
              onSelected: (String selection) {
                cityController
                  ..text = selection
                  ..selection = TextSelection.collapsed(
                    offset: selection.length,
                  );
              },
              fieldViewBuilder:
                  (
                    BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted,
                  ) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onChanged: _onCityChanged,
                      onSubmitted: (_) {
                        onFieldSubmitted();
                        getWeather();
                      },
                      decoration: InputDecoration(
                        labelText: "Nhập thành phố: ",
                        border: OutlineInputBorder(),
                        suffixIcon: isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    );
                  },
              optionsViewBuilder:
                  (
                    BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options,
                  ) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 220,
                            maxWidth: 500,
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final option = options.elementAt(index);
                              return ListTile(
                                title: Text(option),
                                onTap: () => onSelected(option),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: isLoading ? null : getWeather,
              child: Text("Xem thời tiết"),
            ),

            SizedBox(height: 20),

            if (isLoading) CircularProgressIndicator(),

            if (!isLoading && cityName.isNotEmpty)
              Column(
                children: [
                  Text("📍 $cityName", style: TextStyle(fontSize: 22)),

                  if (iconUrl.isNotEmpty) Image.network(iconUrl, width: 100),

                  Text("🌡️ $temp", style: TextStyle(fontSize: 26)),

                  Text(desc, style: TextStyle(fontSize: 18)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
