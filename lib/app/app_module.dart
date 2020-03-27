import 'package:dio/dio.dart';
import 'package:vocabular/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:vocabular/app/app_widget.dart';
import 'package:vocabular/app/modules/import/import_module.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/repositories/file_services.dart';
import 'package:vocabular/app/repositories/options_repository.dart';
import 'package:vocabular/app/repositories/vocab_repository.dart';

import 'modules/box/box_module.dart';
import 'modules/tabs/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController(i.get())),
        Bind((i) => BoxRepository()),
        Bind((i) => VocabRepository()),
        Bind((i) => OptionsRepository()),
        Bind((i) => FileServices()),
        Bind((i) => Dio()),
      ];

  @override
  List<Router> get routers => [
        Router('', module: HomeModule()),
        Router('/box', module: BoxSubModule()),
        Router('/import', module: ImportModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
