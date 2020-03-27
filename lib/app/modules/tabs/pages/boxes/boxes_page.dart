import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/modules/tabs/pages/boxes/widgets/action_bar.dart';
import 'package:vocabular/app/widgets/navigation_shell.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'boxes_controller.dart';

class BoxesPage extends StatefulWidget {
  const BoxesPage({Key key}) : super(key: key);

  @override
  _BoxesPageState createState() => _BoxesPageState();
}

class _BoxesPageState extends ModularState<BoxesPage, BoxesController> {
  int expandedCard = -1;

  @override
  void initState() {
    controller.loadBoxes();
    super.initState();
  }

  Widget buildInitial() => buildLoading();
  Widget buildLoading() => Center(
        child: CircularProgressIndicator(),
      );
  Widget buildEmpty() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Es sieht hier ziemlich leer aus!'),
            Text('Fang doch gleich damit an eine Vokabelbox hinzuzufügen:'),
            SizedBox(
              height: 16,
            ),
            OutlineButton.icon(
              onPressed: controller.addBox,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              icon: Icon(Icons.add),
              label: Text('Box Hinzufügen'),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              //color: Theme.of(context).primaryColor,
            )
          ],
        ),
      );
  Widget buildLoaded() => SingleChildScrollView(
        child: ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.all(8),
          animationDuration: Duration(milliseconds: 200),
          expansionCallback: (i, b) {
            if (!b) {
              controller.expandedCard = i;
            } else if (controller.expandedCard == i) {
              controller.expandedCard = -1;
            }
          },
          children: controller.boxes.map((box) {
            final index = controller.boxes.indexOf(box);
            return buildPanel(index, box);
          }).toList(),
        ),
      );

  void navigateToAndReload(String p, [data]) {
    Navigator.of(context)
        .pushNamed(p, arguments: data)
        .then((value) => controller.loadBoxes());
  }

  ExpansionPanel buildPanel(int index, Box box) => ExpansionPanel(
        isExpanded: controller.expandedCard == index,
        canTapOnHeader: true,
        headerBuilder: (c, b) {
          return ListTile(
            title: Text(box.title),
            subtitle: Text('${box.vocabCount} Vocabs'),
            leading: CircleAvatar(
              child: Text(box.lang.toUpperCase()),
            ),
          );
        },
        body: Column(children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          ActionBar(
            onVocab: () => navigateToAndReload('box/vocabs', box.id),
            onBoxes: () => navigateToAndReload('box', box.id),
            onTest: () => navigateToAndReload('box/test', box.id),
            onOptions: () => navigateToAndReload('box/settings', box.id),
            onShare: () => Navigator.pushNamed(
              context,
              'box/export',
              arguments: box,
            ),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    //return Container(color: Colors.red);
    return NavigationShell(
      0,
      Observer(builder: (context) {
        switch (controller.state) {
          case LoadingState.loading:
            return buildLoading();
          case LoadingState.loaded:
            return buildLoaded();
          case LoadingState.empty:
            return buildEmpty();
          default:
            return buildInitial();
        }
      }),
      smallActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.addBox,
      ),
      bigActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Hinzufügen'),
        onPressed: controller.addBox,
      ),
    );
  }
}
