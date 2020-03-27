import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:vocabular/app/modules/box/vocab_test/results/results_page.dart';

main() {
  testWidgets('ResultsPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(ResultsPage(title: 'Results')));
    final titleFinder = find.text('Results');
    expect(titleFinder, findsOneWidget);
  });
}
