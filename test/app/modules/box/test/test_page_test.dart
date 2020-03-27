import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:vocabular/app/modules/box/test/test_page.dart';

main() {
  testWidgets('TestPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(TestPage(title: 'Test')));
    final titleFinder = find.text('Test');
    expect(titleFinder, findsOneWidget);
  });
}
