import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/models/langs.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';
import 'package:vocabular/app/widgets/title_divider.dart';
import 'box_settings_controller.dart';

class BoxSettingsPage extends StatefulWidget {
  final int id;
  BoxSettingsPage(this.id, {Key key}) : super(key: key);

  @override
  _BoxSettingsPageState createState() => _BoxSettingsPageState();
}

class _BoxSettingsPageState
    extends ModularState<BoxSettingsPage, BoxSettingsController> {
  //use 'controller' variable to access controller

  final titleController = TextEditingController();

  @override
  void initState() {
    if (widget.id == null) return Navigator.pop(context);

    controller
        .loadBox(widget.id)
        .then((value) => titleController.text = controller.box?.title ?? '');

    super.initState();
  }

  Future<void> deleteBoxDialog() async {
    final res = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Box löschen?'),
        content: Text('Willst du wirklich diese Box für immer löschen?'),
        actions: <Widget>[
          FlatButton(
            child: const Text('Abbrechen'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: const Text('Ja'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
    if (res != null && res) {
      await controller.delete();
      Navigator.pop(context);
    }
  }

  Future<bool> save() => controller.save(titleController.text);

  List<Widget> buildTestCount() => [
        ListTile(
          title: Text('Vokabeltest mit ${controller.testCount} Vokabeln'),
        ),
        Slider(
          value: controller.testCount.toDouble(),
          onChanged: (v) => controller.testCount = v.toInt(),
          min: 0,
          max: controller.box.vocabCount.toDouble(),
          divisions: controller.box.vocabCount,
          label: controller.testCount.toString(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (controller.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        return buildLoaded();
      },
    );
  }

  Widget buildLoaded() {
    return WillPopScope(
      onWillPop: save,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Optionen'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: deleteBoxDialog,
            )
          ],
        ),
        body: LayoutFoundation(
          (EdgeInsets p) => Observer(
            builder: (context) => ListView(
              padding: p,
              children: [
                TextField(
                  controller: titleController,
                  onSubmitted: (s) => save(),
                  decoration: InputDecoration(
                    labelText: 'Boxname',
                    border: OutlineInputBorder(),
                  ),
                ),
                SwitchListTile(
                  value: controller.hasFormen,
                  onChanged: (b) => controller.hasFormen = b,
                  title: Text('Formen'),
                  subtitle: Text('Extra Feld, um Deklinationen einzutragen'),
                ),
                ListTile(
                  title: Text(
                    'Sprache',
                    style: TextStyle(
                        color: controller.box.vocabCount > 0
                            ? Theme.of(context).disabledColor
                            : null),
                  ),
                  subtitle: controller.box.vocabCount > 0
                      ? Text('Lösche alle Vokabeln, um die Sprache zu ändern')
                      : null,
                  trailing: DropdownButton<String>(
                    value: controller.lang,
                    disabledHint: Text(controller.lang),
                    icon: Icon(Icons.language),
                    onChanged: controller.box.vocabCount > 0
                        ? null
                        : controller.setLang,
                    items: controller.langs
                        .map((l) => DropdownMenuItem<String>(
                              value: l,
                              child: Text(
                                getLanguageByIsoCode(l, germanLanguagesList)
                                    .name,
                              ),
                            ))
                        .toList(),
                  ),
                ),
                TitleDivider('Vokabelbox'),
                ListTile(
                  title: Text('Anzahl der Fächer'),
                ),
                Slider(
                  value: controller.compartments.toDouble(),
                  onChanged: controller.setCompartments,
                  min: 2,
                  max: 10,
                  divisions: 8,
                  label: controller.compartments.toString(),
                ),
                SwitchListTile(
                  value: controller.mustType,
                  onChanged: (b) => controller.mustType = b,
                  title: Text('Schriftlich abfragen'),
                  subtitle: Text('Frage Karten mit Eingabe ab'),
                ),
                ListTile(
                  title: Text('Fächer zurückgehen'),
                  subtitle: Text(
                    'Anzahl der Fächer, die beim Fehler zurückgegangen werden',
                  ),
                ),
                Slider(
                  value: controller.goback.toDouble(),
                  onChanged: (v) => controller.goback = v.toInt(),
                  min: 0,
                  max: controller.compartments.toDouble() - 1,
                  divisions: controller.compartments - 1,
                  label: controller.goback.toString(),
                ),
                SwitchListTile(
                  value: controller.random,
                  onChanged: (b) => controller.random = b,
                  title: Text('Zufällig abfragen'),
                ),
                TitleDivider('Vokabeltest'),
                if (controller.box.vocabCount > 0) ...buildTestCount(),
                ListTile(
                  title: Text('Sprache'),
                  subtitle: Text(
                    'Lege fest welche Sprache abgefragt wird',
                  ),
                  trailing: ToggleButtons(
                    children: [Text('DE'), Text(controller.lang.toUpperCase())],
                    isSelected: controller.askLang,
                    onPressed: (i) => controller.askForeign = i == 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
