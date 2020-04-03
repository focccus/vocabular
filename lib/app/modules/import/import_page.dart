import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vocabular/app/models/langs.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';
import 'package:vocabular/app/widgets/vocab_table.dart';
import 'import_controller.dart';

class ImportPage extends StatefulWidget {
  final bool canImportBox;
  final String lang;
  const ImportPage({Key key, this.canImportBox = true, this.lang})
      : super(key: key);

  @override
  _ImportPageState createState() => _ImportPageState();
}

class _ImportPageState extends ModularState<ImportPage, ImportController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    if (widget.lang == null) return Navigator.pop(context);

    controller.lang = widget.lang;

    controller.importBox =
        widget.canImportBox != null ? widget.canImportBox : true;

    controller.importFile();
    super.initState();
  }

  void save() async {
    final vocabs = await controller.save();

    Navigator.of(context).pop(vocabs);
  }

  Widget buildInitial() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OutlineButton.icon(
            onPressed: controller.importFile,
            icon: Icon(Icons.folder_open),
            label: Text(translate('import')),
          ),
          SizedBox(
            height: 16,
          ),
          if (controller.errorText != null && controller.errorText.isNotEmpty)
            Text(
              controller.errorText,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget buildLoaded() {
    final w = MediaQuery.of(context).size.width;
    return LayoutFoundation(
      (EdgeInsets p) => Observer(
        builder: (_) => ListView(
          padding: p,
          children: <Widget>[
            Text(
              translate(
                'in.count',
                args: {'num': controller.vocabsMap.length},
              ),
              style: TextStyle(fontSize: 16),
            ),
            VocabTable(
              controller.vocabs,
              showForms: controller.hasFormen,
              lang: getLanguageByIsoContext(controller.lang, context),
            ),
            if ((widget?.canImportBox ?? true) && controller.box != null)
              CheckboxListTile(
                value: controller.importBox,
                onChanged: (v) => controller.importBox = v,
                title: Text(translate('in.box')),
                subtitle: Text(translate('in.box_')),
              ),
            // ListTile(
            //   title: Text(
            //     'Sprache',
            //   ),
            //   trailing: DropdownButton<String>(
            //     value: controller.lang,
            //     icon: Icon(Icons.language),
            //     onChanged: (v) => controller.lang = v,
            //     items: controller.langs
            //         .map((l) => DropdownMenuItem<String>(
            //               value: l,
            //               child: Text(
            //                 getLanguageByIsoCode(l, germanLanguagesList).name,
            //               ),
            //             ))
            //         .toList(),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: w >= 720 ? 64 : 16,
              ),
              child: RaisedButton(
                child: Text(translate('in.confirm')),
                onPressed: save,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('import')),
      ),
      body: Observer(
        builder: (_) {
          if (controller.isLoaded) return buildLoaded();

          return buildInitial();
        },
      ),
    );
  }
}
