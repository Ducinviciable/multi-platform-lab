// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mbi_calculator/main.dart';

void main() {
  testWidgets('calculates bmi from height and weight', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('BMI Calculator'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('heightField')), '170cm');
    await tester.enterText(find.byKey(const Key('weightField')), '65kg');
    await tester.tap(find.byKey(const Key('calculateButton')));
    await tester.pumpAndSettle();

    expect(find.text('Kết quả BMI: 22.5'), findsOneWidget);
    expect(find.text('Bình thường'), findsOneWidget);
  });

  testWidgets('filters out letters from numeric inputs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key('heightField')), '170abc');
    await tester.enterText(find.byKey(const Key('weightField')), '65xyz');
    await tester.pump();

    final EditableText heightField = tester.widget(
      find.descendant(
        of: find.byKey(const Key('heightField')),
        matching: find.byType(EditableText),
      ),
    );
    final EditableText weightField = tester.widget(
      find.descendant(
        of: find.byKey(const Key('weightField')),
        matching: find.byType(EditableText),
      ),
    );

    expect(heightField.controller.text, '170');
    expect(weightField.controller.text, '65');
  });
}
