import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabular/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  await Hive.initFlutter();

  final localization = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    basePath: 'assets/i18n/',
    supportedLocales: [
      'en_US',
      'de',
    ],
  );

  runApp(
    LocalizedApp(localization, ModularApp(module: AppModule())),
  );
}
