import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F7A8C),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, height: 1.4),
        ),
      ),
      home: const BmiHomePage(),
    );
  }
}

class BmiHomePage extends StatefulWidget {
  const BmiHomePage({super.key});

  @override
  State<BmiHomePage> createState() => _BmiHomePageState();
}

class _BmiHomePageState extends State<BmiHomePage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String? _resultTitle;
  String? _resultDescription;
  double? _bmiValue;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculateBmi() {
    final double? height = double.tryParse(_heightController.text.trim());
    final double? weight = double.tryParse(_weightController.text.trim());

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _resultTitle = 'Dữ liệu chưa hợp lệ';
        _resultDescription = 'Nhập chiều cao và cân nặng lớn hơn 0.';
        _bmiValue = null;
      });
      return;
    }

    final double bmi = weight / ((height / 100) * (height / 100));

    setState(() {
      _bmiValue = bmi;
      _resultTitle = 'Kết quả BMI: ${bmi.toStringAsFixed(1)}';
      _resultDescription = _bmiDescription(bmi);
    });
  }

  String _bmiDescription(double bmi) {
    if (bmi < 18.5) {
      return 'Bạn đang ở mức thiếu cân. Hãy ăn uống đầy đủ hơn.';
    }
    if (bmi < 25) {
      return 'Bạn đang ở mức bình thường. Hãy giữ nhịp sống hiện tại.';
    }
    if (bmi < 30) {
      return 'Bạn đang ở mức thừa cân. Nên tăng vận động nhẹ nhàng.';
    }
    return 'Bạn đang ở mức béo phì. Nên theo dõi sức khỏe sớm hơn.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text(
                'BMI Calculator',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2942),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nhập chiều cao và cân nặng để tính chỉ số BMI.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF5A6B7D),
                ),
              ),
              const SizedBox(height: 24),
              _SectionCard(
                title: 'Dữ liệu cơ thể',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _MetricCard(
                            label: 'Chiều cao',
                            hintText: 'cm',
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]'),
                              ),
                            ],
                            keyName: 'heightField',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _MetricCard(
                            label: 'Cân nặng',
                            hintText: 'kg',
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]'),
                              ),
                            ],
                            keyName: 'weightField',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      key: const Key('calculateButton'),
                      onTap: _calculateBmi,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1F7A8C), Color(0xFF2D9CDB)],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF1F7A8C,
                              ).withValues(alpha: 0.25),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Tính BMI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Kết quả',
                child: _bmiValue == null
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _resultTitle ?? '',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F2942),
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _resultDescription ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          _BmiBadge(value: _bmiValue!),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE4EAF1)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F2942),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.inputFormatters,
    required this.keyName,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final String keyName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE4EAF1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFF35506A),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            key: Key(keyName),
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _BmiBadge extends StatelessWidget {
  const _BmiBadge({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final Color textColor;
    final String label;

    if (value < 18.5) {
      backgroundColor = const Color(0xFFFFF4D6);
      textColor = const Color(0xFF9A6700);
      label = 'Thiếu cân';
    } else if (value < 25) {
      backgroundColor = const Color(0xFFE8F7EE);
      textColor = const Color(0xFF2E7D32);
      label = 'Bình thường';
    } else if (value < 30) {
      backgroundColor = const Color(0xFFFFE8D6);
      textColor = const Color(0xFFC25E00);
      label = 'Thừa cân';
    } else {
      backgroundColor = const Color(0xFFFFE0E0);
      textColor = const Color(0xFFB3261E);
      label = 'Béo phì';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}
