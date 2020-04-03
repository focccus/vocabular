import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vocabular/app/app_controller.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends ModularState<AppWidget, AppController> {
  @override
  Widget build(BuildContext context) {
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: Observer(
        builder: (context) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor:
                controller.theme, //or set color with: Color(0xFF0000FF)
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
          ));
          return MaterialApp(
            navigatorKey: Modular.navigatorKey,
            title: 'Vocabular',
            theme: ThemeData(
              brightness:
                  controller.isDark ? Brightness.dark : Brightness.light,
              primarySwatch: controller.theme,
              accentColor: controller.isDark
                  ? controller.theme.shade200
                  : controller.theme,

              buttonTheme: ButtonThemeData(
                buttonColor: controller.theme.shade600,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                minWidth: 300,
                textTheme: ButtonTextTheme.normal,
              ),

              toggleableActiveColor: controller.theme,

              // appBarTheme: AppBarTheme(
              //   elevation: 0,
              //   color: Colors.white,
              // ),
            ),
            initialRoute: '/',
            onGenerateRoute: Modular.generateRoute,
          );
        },
      ),
    );
  }
}
