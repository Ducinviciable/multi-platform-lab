import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:xylophone/main.dart';

void main() {
  testWidgets('Xylophone displays 7 color keys', (WidgetTester tester) async {
    await tester.pumpWidget(const XylophoneApp());

    expect(find.byType(TextButton), findsNWidgets(7));
  });
}
