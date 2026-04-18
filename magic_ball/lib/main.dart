import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MagicBallApp());
}

class MagicBallApp extends StatelessWidget {
  const MagicBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic 8 Ball',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MagicBallScreen(),
    );
  }
}

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  final Random _random = Random();
  int _ballNumber = 1;

  void _changeBallImage() {
    setState(() {
      _ballNumber = _random.nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Magic 8 Ball'), centerTitle: true),
      body: Center(
        child: TextButton(
          onPressed: _changeBallImage,
          child: Image.asset('assets/images/ball$_ballNumber.png'),
        ),
      ),
    );
  }
}
