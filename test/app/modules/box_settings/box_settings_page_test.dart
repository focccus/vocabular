import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:vocabular/app/modules/box_settings/box_settings_page.dart';

main() {
  testWidgets('BoxSettingsPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(BoxSettingsPage(title: 'BoxSettings')));
    final titleFinder = find.text('BoxSettings');
    expect(titleFinder, findsOneWidget);
  });
}
