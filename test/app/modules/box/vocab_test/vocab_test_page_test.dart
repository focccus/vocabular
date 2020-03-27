import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:vocabular/app/modules/box/vocab_test/vocab_test_page.dart';

main() {
  testWidgets('VocabTestPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(VocabTestPage(title: 'VocabTest')));
    final titleFinder = find.text('VocabTest');
    expect(titleFinder, findsOneWidget);
  });
}
