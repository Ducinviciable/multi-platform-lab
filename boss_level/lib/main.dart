import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'story_data.dart';

void main() {
  runApp(const BossLevelApp());
}

class BossLevelApp extends StatelessWidget {
  const BossLevelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boss Level',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2B6CB0)),
        useMaterial3: true,
      ),
      home: const StoryGamePage(),
    );
  }
}

class StoryGamePage extends StatefulWidget {
  const StoryGamePage({super.key});

  @override
  State<StoryGamePage> createState() => _StoryGamePageState();
}

class _StoryGamePageState extends State<StoryGamePage> {
  final Map<int, StoryNode> _nodes = storyNodes;

  int _currentNodeId = 0;
  int _affection = 0;
  int _courage = 0;
  EndingResult? _ending;

  void _applyChoice(StoryChoice choice) {
    setState(() {
      _affection += choice.affectionDelta;
      _courage += choice.courageDelta;

      if (choice.nextNodeId == lostNodeId) {
        _ending = lostEnding;
        return;
      }

      if (choice.nextNodeId == endingCheckNodeId) {
        _ending = resolveEnding(affection: _affection, courage: _courage);
        return;
      }

      _currentNodeId = choice.nextNodeId;
    });
  }

  void _restartGame() {
    setState(() {
      _currentNodeId = 0;
      _affection = 0;
      _courage = 0;
      _ending = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final StoryNode? node = _nodes[_currentNodeId];
    final String backgroundAsset =
        _ending?.backgroundAsset ??
        node?.backgroundAsset ??
        'assets/backgrounds/summer_intro.svg';

    return Scaffold(
      appBar: AppBar(title: const Text('Boss Level - Interactive Story')),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(backgroundAsset, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.12),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _ending != null
                  ? _EndingView(
                      ending: _ending!,
                      affection: _affection,
                      courage: _courage,
                      onRestart: _restartGame,
                    )
                  : node == null
                  ? const Center(child: Text('Khong tim thay node truyen.'))
                  : _StoryNodeView(
                      node: node,
                      affection: _affection,
                      courage: _courage,
                      onChoiceTap: _applyChoice,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryNodeView extends StatelessWidget {
  const _StoryNodeView({
    required this.node,
    required this.affection,
    required this.courage,
    required this.onChoiceTap,
  });

  final StoryNode node;
  final int affection;
  final int courage;
  final ValueChanged<StoryChoice> onChoiceTap;

  @override
  Widget build(BuildContext context) {
    final Color moodColor = node.mood == 'dere'
        ? const Color(0xFFB83280)
        : const Color(0xFF2C5282);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 0,
          color: Colors.white.withValues(alpha: 0.58),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Affection: $affection   Courage: $courage',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: moodColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Mood: ${node.mood}',
                    style: TextStyle(
                      color: moodColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Card(
            elevation: 0,
            color: Colors.white.withValues(alpha: 0.56),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    node.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    node.story,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF2F7).withValues(alpha: 0.52),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Alice: ${node.dialogue}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Spacer(),
                  for (final StoryChoice choice in node.choices)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => onChoiceTap(choice),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(choice.text),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EndingView extends StatelessWidget {
  const _EndingView({
    required this.ending,
    required this.affection,
    required this.courage,
    required this.onRestart,
  });

  final EndingResult ending;
  final int affection;
  final int courage;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        color: Colors.white.withValues(alpha: 0.56),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ending.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(
                ending.story,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text('Tong Affection: $affection | Tong Courage: $courage'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRestart,
                child: const Text('Choi Lai'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
