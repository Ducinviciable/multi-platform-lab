import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dice/main.dart';

void main() {
  testWidgets('roll button updates both dice', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(random: _SequenceRandom(<int>[1, 4, 0, 3])));

    expect(find.text('⚀'), findsOneWidget);
    expect(find.text('⚅'), findsOneWidget);
    expect(find.text('Lăn xúc xắc'), findsOneWidget);

    await tester.tap(find.text('Lăn xúc xắc'));
    await tester.pump();

    expect(find.text('⚁'), findsOneWidget);
    expect(find.text('⚄'), findsOneWidget);
    expect(find.text('⚀'), findsNothing);
    expect(find.text('⚅'), findsNothing);
  });
}

class _SequenceRandom implements Random {
  _SequenceRandom(this.values);

  final List<int> values;
  int _index = 0;

  @override
  int nextInt(int max) {
    final int value = values[_index % values.length] % max;
    _index += 1;
    return value;
  }

  @override
  bool nextBool() => nextInt(2) == 0;

  @override
  double nextDouble() => nextInt(1000000) / 1000000;
}
