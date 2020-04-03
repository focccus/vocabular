import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:language_pickers/language_pickers.dart';
import 'package:language_pickers/languages.dart';
import 'package:vocabular/app/models/langs.dart';
import 'package:vocabular/app/widgets/language_tile.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';
import 'package:vocabular/app/widgets/navigation_shell.dart';
import 'package:vocabular/app/widgets/title_divider.dart';
import 'package:vocabular/app/widgets/yes_no_dialog.dart';
import 'settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState
    extends ModularState<SettingsPage, SettingsController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    controller.loadOptions();
    super.initState();
  }

  void addLang() {
    showDialog<Language>(
      context: context,
      builder: (context) => LanguagePickerDialog(
        titlePadding: EdgeInsets.all(8.0),
        searchCursorColor: Colors.pinkAccent,
        searchInputDecoration: InputDecoration(
          hintText: translate('search') + '...',
        ),
        isSearchable: true,
        title: Text(translate('settings.choose_language')),
        onValuePicked: (Language lang) => controller.addLang(lang.isoCode),
        itemBuilder: (lang) => LanguageTile(lang),
        languagesList: germanLanguagesList
            .cast<Map<String, String>>()
            .where((value) => !controller.langs.contains(value['isoCode']))
            .toList(),
      ),
    );
  }

  void removeLang(String lang) async {
    if (await controller.checkDeletable(lang)) {
      final res = await showYesNoDialog(
        context,
        translate('settings.confirm_delete', args: {
          'lang': getLanguageByIsoContext(lang, context),
        }),
      );

      if (res != null && res) {
        controller.removeLang(lang);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(translate('settings.not_deletable')),
          content: Text(translate('settings.not_deletable_text')),
          actions: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(),
              textColor: Colors.white,
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationShell(
      2,
      Observer(
        builder: (context) {
          if (controller.isLoading) return Container();
          return buildLoaded();
        },
      ),
    );
  }

  Widget buildLoaded() {
    final w = MediaQuery.of(context).size.width;

    return LayoutFoundation(
      (EdgeInsets p) => Observer(
        builder: (_) => ListView(
          padding: p.copyWith(top: 32),
          children: <Widget>[
            TitleDivider(translate('settings.languages')),
            ListBody(
              children: controller.langs
                  .map((l) => LanguageTile(
                        getLanguageByIsoCode(
                          l,
                          LocalizedApp.of(context)
                              .delegate
                              .currentLocale
                              .languageCode,
                        ),
                        onLongPress: () => removeLang(l),
                      ))
                  .toList(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w >= 720 ? 64 : 16,
              ),
              child: OutlineButton.icon(
                onPressed: addLang,
                icon: Icon(Icons.language),
                label: Text(translate('settings.add_language')),
              ),
            ),
            TitleDivider(translate('settings.grades')),
            ListTile(
              leading: Icon(Icons.blur_circular),
              title: Text(
                translate('settings.choose_grade'),
              ),
              trailing: DropdownButton<String>(
                value: controller.grades,
                onChanged: controller.setGrade,
                items: controller.gradingOptions.map((l) {
                  String text;

                  if (l == 'us')
                    text = 'A - F';
                  else if (l == 'ob')
                    text = '15 - 0';
                  else
                    text = '1 - 6';

                  return DropdownMenuItem<String>(
                    value: l,
                    child: Text(
                      text,
                    ),
                  );
                }).toList(),
              ),
            ),
            TitleDivider(translate('settings.appearence')),
            SwitchListTile(
              value: controller.isDark,
              onChanged: controller.toggleDarkMode,
              title: Text(translate('settings.dark_mode')),
            ),
            ColorChooser(
              controller.color,
              controller.colorOptions,
              controller.setColor,
            ),
          ],
        ),
      ),
    );
  }
}

class ColorChooser extends StatelessWidget {
  final MaterialColor color;
  final List<MaterialColor> colors;
  final void Function(MaterialColor) onColorChanged;

  ColorChooser(this.color, this.colors, this.onColorChanged);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: colors
            .map(
              (c) => InkWell(
                onTap: () => onColorChanged(c),
                splashColor: c,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (c == color)
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                          spreadRadius: 1,
                        )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
