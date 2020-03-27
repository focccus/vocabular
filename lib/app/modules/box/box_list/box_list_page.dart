import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/models/langs.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/widgets/insert_dialog/insert_dialog.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';
import 'package:vocabular/app/widgets/vocab_table.dart';
import 'box_list_controller.dart';

class BoxListPage extends StatefulWidget {
  final int id;
  const BoxListPage(this.id, {Key key}) : super(key: key);

  @override
  _BoxListPageState createState() => _BoxListPageState();
}

class _BoxListPageState extends ModularState<BoxListPage, BoxListController> {
  //use 'controller' variable to access controller
  @override
  void initState() {
    if (widget.id == null) return Navigator.pop(context);

    controller.loadBox(widget.id).then((box) {
      if (box.vocabCount <= 0) {
        editVocab();
      }
    });
    super.initState();
  }

  void editVocab([Vocab v]) async {
    final vocab = await showDialog<Vocab>(
      context: context,
      builder: (context) => VocabDialog(
        loadFromStorage: true,
        hasFormen: controller.box.hasFormen,
        lang: controller.box.lang,
        vocab: v,
      ),
    );
    if (vocab != null) {
      controller.saveVocab(v?.id, vocab);
      if (v == null) Timer(Duration(milliseconds: 500), () => editVocab());
    }
  }

  void import() async {
    final vocabs = (await Modular.to.pushNamed(
      'import',
      arguments: {'lang': controller.box.lang, 'canImportBox': false},
    ) as List<Vocab>);
    if (vocabs != null && vocabs.isNotEmpty) {
      controller.importVocabs(vocabs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        switch (controller.status) {
          case LoadingState.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case LoadingState.loaded:
            return buildLoaded();

          default:
            return buildEmpty();
        }
      },
    );
  }

  Widget buildShell(Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.box?.title ?? 'Vokabelbox'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.folder_open),
            tooltip: 'Import Vocabs',
            onPressed: import,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: editVocab,
        icon: Icon(Icons.add),
        label: Text('Hinzufügen'),
      ),
      body: child,
    );
  }

  Widget buildEmpty() {
    return buildShell(
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Füge deine erste Vokabel hinzu:'),
            SizedBox(
              height: 16,
            ),
            OutlineButton.icon(
              onPressed: editVocab,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              icon: Icon(Icons.add),
              label: Text('Vokabel Hinzufügen'),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              //color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoaded() {
    return buildShell(
      LayoutFoundation(
        (EdgeInsets p) => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: p,
          child: LayoutBuilder(
            builder: (context, constraints) => ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Observer(
                    builder: (context) => VocabTable(
                      controller.vocabs,
                      showForms: controller.box.hasFormen,
                      lang: getLanguageByIsoCode(
                        controller.box.lang,
                        germanLanguagesList,
                      ).name,
                      onSelected: editVocab,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
