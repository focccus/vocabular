import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:vocabular/app/repositories/options_repository.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  Color theme = Colors.indigo;
  OptionsRepository options;

  _AppControllerBase(this.options) {
    options.initHive();
  }
}
