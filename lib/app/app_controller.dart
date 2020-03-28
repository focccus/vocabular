import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:vocabular/app/repositories/options_repository.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final List<MaterialColor> colorOptions = [
    Colors.indigo,
    Colors.purple,
    Colors.lightBlue,
    Colors.green,
    Colors.orange
  ];

  @observable
  MaterialColor theme = Colors.indigo;

  @observable
  bool isDark = false;
  OptionsRepository options;

  void _getOptions() async {
    await options.initHive();
    isDark = (await options.getOption('dark')) ?? false;
    String color = await options.getOption('theme');

    switch (color) {
      case 'purple':
        theme = Colors.purple;

        break;
      case 'lightBlue':
        theme = Colors.lightBlue;

        break;
      case 'green':
        theme = Colors.green;

        break;
      case 'orange':
        theme = Colors.orange;

        break;
      default:
        theme = Colors.indigo;
    }
  }

  _AppControllerBase(this.options) {
    _getOptions();
  }

  @action
  void setColor(MaterialColor c) {
    String colorName = _colortoString(c);
    theme = c;

    options.saveOption('theme', colorName);
  }

  @action
  void setBrightness(bool v) {
    isDark = v;

    options.saveOption('dark', v);
  }

  String _colortoString(MaterialColor c) {
    if (c == Colors.purple) return 'purple';
    if (c == Colors.orange) return 'orange';
    if (c == Colors.lightBlue) return 'lightBlue';
    if (c == Colors.green) return 'green';
    return 'indigo';
  }
}
