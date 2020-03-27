import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';
import 'package:vocabular/app/widgets/title_divider.dart';
import 'package:vocabular/app/widgets/vocab_table.dart';
import 'export_controller.dart';

class ExportPage extends StatefulWidget {
  final Box box;
  const ExportPage(this.box, {Key key}) : super(key: key);

  @override
  _ExportPageState createState() => _ExportPageState();
}

class _ExportPageState extends ModularState<ExportPage, ExportController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    if (widget.box == null) return Navigator.of(context).pop();

    controller.loadVocabs(widget.box);

    super.initState();
  }

  Widget buildLoaded() {
    return LayoutFoundation(
      (EdgeInsets p) => ListView(
        padding: p,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Hier kannst du deine Vokabelbox exportieren. Wähle einfach die Vokabeln aus und teile sie mit deinen Freunden!',
              textAlign: TextAlign.center,
            ),
          ),
          VocabTable(
            controller.vocabs,
            selected: controller.selected?.toList(),
            onSelected: controller.select,
          ),
          CheckboxListTile(
            value: controller.justExportVocabs,
            onChanged: (v) => controller.justExportVocabs = v,
            title: Text('Nur Vokabeln exportieren'),
            subtitle: Text(
              'Teile nur die einzelnen Vokabeln ohne die streng geheime Box freizugeben',
            ),
          ),
          CheckboxListTile(
            value: controller.includeCompartments,
            onChanged: (v) => controller.includeCompartments = v,
            title: Text('Speichere Fächer'),
            subtitle: Text(
              'Lege fest, ob der Fortschritt im Vokabeltrainer exportiert werden soll',
            ),
          ),
          Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(16),
              child: RaisedButton.icon(
                padding: const EdgeInsets.all(8),
                textColor: Colors.white,
                onPressed: controller.export,
                icon: Icon(Icons.file_download),
                label: Text('Exportieren'),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teilen'),
      ),
      body: Observer(
        builder: (context) {
          if (controller.isLoading)
            return Center(child: CircularProgressIndicator());
          return buildLoaded();
        },
      ),
    );
  }
}
