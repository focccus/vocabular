import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter/services.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Vocabular',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigo.shade600,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          minWidth: 300,
          textTheme: ButtonTextTheme.normal,
        ),

        // appBarTheme: AppBarTheme(
        //   elevation: 0,
        //   color: Colors.white,
        // ),
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
