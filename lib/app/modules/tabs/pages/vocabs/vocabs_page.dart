import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vocabular/app/models/langs.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/widgets/insert_dialog/insert_dialog.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';
import 'package:vocabular/app/widgets/navigation_shell.dart';
import 'package:vocabular/app/widgets/vocab_table.dart';
import 'vocabs_controller.dart';

class VocabsPage extends StatefulWidget {
  const VocabsPage({Key key}) : super(key: key);

  @override
  _VocabsPageState createState() => _VocabsPageState();
}

class _VocabsPageState extends ModularState<VocabsPage, VocabsController> {
  //use 'controller' variable to access controller

  TextEditingController searchController = TextEditingController();

  Future addVocab([Vocab v]) async {
    final vocab = await showDialog<Vocab>(
      context: context,
      builder: (context) => VocabDialog(
        hasFormen: true,
        loadFromStorage: false,
        vocab: v,
        lang: controller.selectedLang,
      ),
    );

    if (vocab != null) {
      await controller.saveVocab(v?.id, vocab);
      controller.searchVocabs(searchController.text);
    }
  }

  void import() async {
    final vocabs = (await Modular.to.pushNamed(
      'import',
      arguments: {'lang': controller.selectedLang},
    ) as List<Vocab>);
    if (vocabs != null && vocabs.isNotEmpty) {
      controller.addVocabs(vocabs, searchController.text);
    }
  }

  @override
  void initState() {
    controller.loadLangs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationShell(
      1,
      Observer(builder: (context) {
        if (controller.isLoading) return Container();
        return buildLoaded();
      }),
      smallActionButton: FloatingActionButton(
        onPressed: addVocab,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildTable() {
    return LayoutFoundation(
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
                child: Observer(builder: (context) {
                  return VocabTable(
                    controller.displayedVocabs,
                    showForms: controller.showForms,
                    lang: getLanguageByIsoContext(
                        controller.selectedLang, context),
                    onSelected: addVocab,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoaded() {
    final w = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w >= 720 ? 32.0 : 16,
            vertical: 8,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: controller.searchVocabs,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: DropdownButton<String>(
                        value: controller.selectedLang,
                        //icon: Icon(Icons.language),
                        onChanged: (l) {
                          controller.selectedLang = l;
                          controller.loadVocabs();
                        },
                        items: controller.langs
                            .map((l) => DropdownMenuItem<String>(
                                  value: l,
                                  child:
                                      Text(getLanguageByIsoContext(l, context)),
                                ))
                            .toList(),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: translate('list.browse'),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              IconButton(
                icon: Icon(Icons.folder_open),
                tooltip: translate('import'),
                onPressed: import,
              ),
              // DropdownButton<String>(
              //   value: 'en',
              //   icon: Icon(Icons.language),
              //   onChanged: (i) => print(i),
              //   items: controller.langs
              //       .map((l) => DropdownMenuItem<String>(
              //             value: l,
              //             child: Text(
              //               getLanguageByIsoCode(l, germanLanguagesList).name,
              //             ),
              //           ))
              //       .toList(),
              // ),
            ],
          ),
        ),
        Expanded(
          child: Observer(
            builder: (context) {
              if (controller.vocabState == LoadingState.loaded)
                return buildTable();
              if (controller.vocabState == LoadingState.loading)
                return Center(
                  child: CircularProgressIndicator(),
                );

              return Center(
                child: Text(translate('list.no_vocabs')),
              );
            },
          ),
        )
      ],
    );
  }
}
