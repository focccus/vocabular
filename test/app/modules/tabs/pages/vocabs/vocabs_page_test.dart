import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:vocabular/app/modules/tabs/pages/vocabs/vocabs_page.dart';

main() {
  testWidgets('VocabsPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(VocabsPage(title: 'Vocabs')));
    final titleFinder = find.text('Vocabs');
    expect(titleFinder, findsOneWidget);
  });
}
