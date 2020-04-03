import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vocabular/app/models/langs.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';
import 'package:vocabular/app/widgets/title_divider.dart';
import 'package:vocabular/app/widgets/yes_no_dialog.dart';
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
    final res = await showYesNoDialog(
      context,
      translate('box.delete_box') + '?',
      content: translate('box.delete_box_'),
    );
    if (res != null && res) {
      await controller.delete();
      Navigator.pop(context);
    }
  }

  Future<bool> save() => controller.save(titleController.text);

  List<Widget> buildTestCount() => [
        ListTile(
          title: Text(translate(
            'box.vocab_test_count',
            args: {'count': controller.testCount},
          )),
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
          title: Text(translate('box.options')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_outline),
              tooltip: translate('box.delete_box'),
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
                    labelText: translate('box.name'),
                    border: OutlineInputBorder(),
                  ),
                ),
                SwitchListTile(
                  value: controller.hasFormen,
                  onChanged: (b) => controller.hasFormen = b,
                  title: Text(translate('box.forms')),
                  subtitle: Text(translate('box.forms_')),
                ),
                ListTile(
                  title: Text(
                    translate('box.language'),
                    style: TextStyle(
                        color: controller.box.vocabCount > 0
                            ? Theme.of(context).disabledColor
                            : null),
                  ),
                  subtitle: controller.box.vocabCount > 0
                      ? Text(translate('box.delete_lang'))
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
                                getLanguageByIsoContext(
                                  controller.lang,
                                  context,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                TitleDivider(translate('box.vocab_box')),
                ListTile(
                  title: Text(translate('box.compartment_count')),
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
                  title: Text(translate('box.write')),
                  subtitle: Text(translate('box.write_')),
                ),
                ListTile(
                  title: Text(translate('box.goback')),
                  subtitle: Text(
                    translate('box.goback_'),
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
                  title: Text(translate('box.random')),
                ),
                TitleDivider(translate('box.vocab_test')),
                if (controller.box.vocabCount > 0) ...buildTestCount(),
                ListTile(
                  title: Text(translate('box.language')),
                  subtitle: Text(
                    translate('box.language_'),
                  ),
                  trailing: ToggleButtons(
                    children: [
                      Text(translate('iso').toUpperCase()),
                      Text(controller.lang.toUpperCase())
                    ],
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
