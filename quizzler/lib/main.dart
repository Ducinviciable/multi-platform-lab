import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const QuizPage(),
    );
  }
}

class QuizQuestion {
  const QuizQuestion({required this.question, required this.answer});

  final String question;
  final bool answer;
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<QuizQuestion> _questions = const [
    QuizQuestion(
      question:
          'Ngôn ngữ Dart được phát triển chủ yếu để xây dựng ứng dụng Flutter.',
      answer: true,
    ),
    QuizQuestion(
      question:
          'Python là ngôn ngữ lập trình biên dịch hoàn toàn trước khi chạy.',
      answer: false,
    ),
    QuizQuestion(
      question: 'Java hỗ trợ lập trình hướng đối tượng.',
      answer: true,
    ),
    QuizQuestion(
      question: 'C++ không cho phép sử dụng con trỏ.',
      answer: false,
    ),
    QuizQuestion(
      question: 'JavaScript thường được dùng để phát triển giao diện web.',
      answer: true,
    ),
    QuizQuestion(
      question: 'Kotlin là ngôn ngữ chính thức được Google hỗ trợ cho Android.',
      answer: true,
    ),
    QuizQuestion(
      question: 'Swift là ngôn ngữ do Microsoft tạo ra để viết ứng dụng iOS.',
      answer: false,
    ),
    QuizQuestion(
      question:
          'C là ngôn ngữ bậc cao hoàn toàn không liên quan đến hệ điều hành.',
      answer: false,
    ),
    QuizQuestion(
      question: 'TypeScript là JavaScript có bổ sung hệ thống kiểu dữ liệu.',
      answer: true,
    ),
    QuizQuestion(
      question:
          'Rust được thiết kế với mục tiêu tăng an toàn bộ nhớ và hiệu năng.',
      answer: true,
    ),
  ];

  int _currentQuestionIndex = 0;
  final List<Icon> _scoreKeeper = [];

  void _handleAnswer(bool userAnswer) {
    final bool isCorrect =
        _questions[_currentQuestionIndex].answer == userAnswer;

    setState(() {
      _scoreKeeper.add(
        Icon(
          isCorrect ? Icons.check : Icons.close,
          color: isCorrect ? Colors.green : Colors.red,
        ),
      );

      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showFinishDialog();
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _scoreKeeper.clear();
    });
  }

  void _showFinishDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hoàn thành'),
          content: const Text('Bạn đã trả lời xong 10 câu hỏi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
              child: const Text('Làm lại'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quizzler - Đúng / Sai')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  _questions[_currentQuestionIndex].question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () => _handleAnswer(true),
                child: const Text(
                  'True',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => _handleAnswer(false),
                child: const Text(
                  'False',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(spacing: 8, children: _scoreKeeper),
          ],
        ),
      ),
    );
  }
}
