import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/modules/box/vocab_test/results/results_controller.dart';
import 'package:vocabular/app/repositories/grade_tables.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';
import 'package:vocabular/app/widgets/yes_no_dialog.dart';

import '../vocab_value.dart';

class ResultsPage extends StatefulWidget {
  final int id;
  final List<VocabTestValue> vocabs;
  const ResultsPage(this.id, this.vocabs, {Key key}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends ModularState<ResultsPage, ResultsController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    if (widget.vocabs == null || widget.vocabs.isEmpty)
      Navigator.of(context).pop();

    controller.calculateResults(widget.id, widget.vocabs);

    super.initState();
  }

  Future<bool> canPop() {
    return showYesNoDialog(
      context,
      'Willst du zurückgehen?',
      content: 'Die Ergebnisse des Tests werden dabei gelöscht.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: canPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Ergebnisse'),
          ),
          body: Observer(
            builder: (context) {
              if (controller.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return buildLoaded();
            },
          )),
    );
  }

  Widget buildLoaded() {
    final w = MediaQuery.of(context).size.width;

    final double circleSize = w > 360 ? 360 : w - 16;

    return LayoutFoundation(
      (EdgeInsets p) => ListView(
        padding: p,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: circleSize,
                  width: circleSize,
                  child: CircularProgressIndicator(
                    value: controller.percentage,
                    strokeWidth: circleSize / 45,
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        controller.grade,
                        style: TextStyle(fontSize: 48),
                      ),
                      Text(
                        '${controller.points} von ${controller.totalPoints} Punkten',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.all(8),
            animationDuration: Duration(milliseconds: 200),
            expansionCallback: (i, b) {
              if (!b) {
                controller.expandedCard = i;
              } else if (controller.expandedCard == i) {
                controller.expandedCard = -1;
              }
            },
            children: controller.vocabs.map((v) => buildPanel(v)).toList(),
          ),
        ],
      ),
    );
  }

  ExpansionPanel buildPanel(VocabTestValue v) => ExpansionPanel(
        isExpanded: controller.expandedCard == controller.vocabs.indexOf(v),
        canTapOnHeader: true,
        headerBuilder: (c, b) {
          return ListTile(
            title: Text(
              controller.box.getDisplayText(v.vocab) +
                  (b ? '' : ' - ${v.input}'),
            ),
            trailing: b ? null : MistakeIndicator(v.mistakes),
          );
        },
        body: Column(
          children: <Widget>[
            buildMistakeTile(
              v.input,
              controller.box.getDisplayText(v.vocab, true),
              v.valueMistakes,
            ),
            if (controller.box.hasFormen)
              buildMistakeTile(
                v.inputForms,
                v.vocab.forms,
                v.formsMistakes,
              ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      );

  ListTile buildMistakeTile(String input, String correction, int mistake) =>
      ListTile(
        leading: Container(
          constraints: BoxConstraints(minWidth: 200),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade100,
          ),
          child: Text(input ?? ''),
        ),
        title: Text(
          correction,
        ),
        trailing: MistakeIndicator((mistake ?? 2) / 2),
      );
}

class MistakeIndicator extends StatelessWidget {
  final num v;

  MistakeIndicator(this.v);

  @override
  Widget build(BuildContext context) {
    if (v > 0)
      return Text(
        '-' + v.toStringAsFixed(1),
        style: TextStyle(color: Colors.red),
      );
    return Icon(
      Icons.done,
      color: Colors.green,
    );
  }
}
