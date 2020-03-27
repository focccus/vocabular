import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:vocabular/app/modules/boxes/boxes_page.dart';

main() {
  testWidgets('BoxesPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(BoxesPage(title: 'Boxes')));
    final titleFinder = find.text('Boxes');
    expect(titleFinder, findsOneWidget);
  });
}
