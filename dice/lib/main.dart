import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.random});

  final Random? random;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice Roller',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB347),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      home: DicePage(random: random ?? Random()),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key, required this.random});

  final Random random;

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  static const List<String> _diceFaces = <String>['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];

  late int _leftDice;
  late int _rightDice;

  @override
  void initState() {
    super.initState();
    _leftDice = 0;
    _rightDice = 5;
  }

  void _rollDice() {
    setState(() {
      _leftDice = widget.random.nextInt(6);
      _rightDice = widget.random.nextInt(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFFFFE0B2),
              Color(0xFFFFF3E0),
              Color(0xFFFFCC80),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Dice Roller',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nhấn nút để tung hai xúc xắc',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _DiceFace(face: _diceFaces[_leftDice]),
                      const SizedBox(width: 24),
                      _DiceFace(face: _diceFaces[_rightDice]),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: _rollDice,
                    icon: const Icon(Icons.casino),
                    label: const Text('Lăn xúc xắc'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DiceFace extends StatelessWidget {
  const _DiceFace({required this.face});

  final String face;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        face,
        style: const TextStyle(
          fontSize: 68,
          color: Color(0xFF212121),
          height: 1,
        ),
      ),
    );
  }
}
