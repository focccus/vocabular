import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vocabular/app/modules/box_list/box_list_controller.dart';
import 'package:vocabular/app/modules/box_list/box_list_module.dart';

void main() {
  initModule(BoxListModule());
  BoxListController boxlist;

  setUp(() {
    boxlist = BoxListModule.to.get<BoxListController>();
  });

  group('BoxListController Test', () {
    test("First Test", () {
      expect(boxlist, isInstanceOf<BoxListController>());
    });

    test("Set Value", () {
      expect(boxlist.value, equals(0));
      boxlist.increment();
      expect(boxlist.value, equals(1));
    });
  });
}
