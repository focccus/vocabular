import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
        searchInputDecoration: InputDecoration(hintText: 'Suchen...'),
        isSearchable: true,
        title: Text('Wähle deine Sprache'),
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
        'Willst du ${getLanguageByIsoCode(lang, germanLanguagesList)} wirklich löschen?',
      );

      if (res != null && res) {
        controller.removeLang(lang);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sprache nicht löschbar'),
          content: Text('Bitte entferne zuvor alle Vokabeln dieser Sprache.'),
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
      (EdgeInsets p) => ListView(
        padding: p.copyWith(top: 32),
        children: <Widget>[
          TitleDivider('Sprachen'),
          ListBody(
            children: controller.langs
                .map((l) => LanguageTile(
                      getLanguageByIsoCode(l, germanLanguagesList),
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
              label: Text('Sprache hinzufügen'),
            ),
          ),
          TitleDivider('Noten'),
          ListTile(
            leading: Icon(Icons.blur_circular),
            title: Text(
              'Wähle die gewünschte Bewertungsform',
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
          TitleDivider('Aussehen'),
        ],
      ),
    );
  }
}
