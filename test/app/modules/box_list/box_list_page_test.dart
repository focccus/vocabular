import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:vocabular/app/modules/box_list/box_list_page.dart';

main() {
  testWidgets('BoxListPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(BoxListPage(title: 'BoxList')));
    final titleFinder = find.text('BoxList');
    expect(titleFinder, findsOneWidget);
  });
}
