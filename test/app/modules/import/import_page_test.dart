import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:vocabular/app/modules/import/import_page.dart';

main() {
  testWidgets('ImportPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(ImportPage(title: 'Import')));
    final titleFinder = find.text('Import');
    expect(titleFinder, findsOneWidget);
  });
}
