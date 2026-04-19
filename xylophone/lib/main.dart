import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  static final AudioPlayer _player = AudioPlayer();

  static Future<void> _playNote(int noteNumber) async {
    await _player.play(AssetSource('audio/note$noteNumber.wav'));
  }

  Widget _buildKey({required Color color, required int noteNumber}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(),
        ),
        onPressed: () => _playNote(noteNumber),
        child: const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildKey(color: Colors.red, noteNumber: 1),
            _buildKey(color: Colors.orange, noteNumber: 2),
            _buildKey(color: Colors.yellow, noteNumber: 3),
            _buildKey(color: Colors.green, noteNumber: 4),
            _buildKey(color: Colors.teal, noteNumber: 5),
            _buildKey(color: Colors.blue, noteNumber: 6),
            _buildKey(color: Colors.purple, noteNumber: 7),
          ],
        ),
      ),
    );
  }
}
