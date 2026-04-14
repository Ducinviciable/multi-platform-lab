import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:i_am_rich/main.dart';

void main() {
  testWidgets('I Am Rich screen renders text and image', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const IAmRichApp());

    expect(find.text('I Am Rich'), findsNWidgets(2));
    expect(find.byType(Image), findsOneWidget);
  });
}
