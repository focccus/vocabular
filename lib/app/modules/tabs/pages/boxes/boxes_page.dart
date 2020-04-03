import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
            Text(
              translate('box.empty'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            OutlineButton.icon(
              onPressed: controller.addBox,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              icon: Icon(Icons.add),
              label: Text(translate('box.add_box')),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              //color: Theme.of(context).primaryColor,
            )
          ],
        ),
      );
  Widget buildLoaded() => SingleChildScrollView(
        child: Observer(
          builder: (_) => BoxPanelList(
            expanded: controller.expandedCard,
            onSelected: (i) => controller.expandedCard = i,
            boxes: controller.boxes,
            navigateToAndReload: navigateToAndReload,
          ),
        ),
      );

  void navigateToAndReload(String p, [data]) {
    Navigator.of(context).pushNamed(p, arguments: data).then(
          (value) => controller.loadBoxes(),
        );
  }

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
        label: Text(translate('add')),
        onPressed: controller.addBox,
      ),
    );
  }
}

class BoxPanelList extends StatelessWidget {
  final int expanded;
  final List<Box> boxes;
  final void Function(String, [dynamic]) navigateToAndReload;
  final void Function(int) onSelected;

  const BoxPanelList({
    Key key,
    this.expanded,
    this.boxes,
    this.navigateToAndReload,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.all(8),
      animationDuration: Duration(milliseconds: 200),
      expansionCallback: (i, b) {
        if (!b) {
          onSelected(i);
        } else if (expanded == i) {
          onSelected(-1);
        }
      },
      children: boxes.map((box) {
        final index = boxes.indexOf(box);
        return buildPanel(context, index, box);
      }).toList(),
    );
  }

  ExpansionPanel buildPanel(BuildContext context, int index, Box box) =>
      ExpansionPanel(
        isExpanded: expanded == index,
        canTapOnHeader: true,
        headerBuilder: (c, b) {
          return ListTile(
            title: Text(box.title),
            subtitle: Text(
              '${box.vocabCount} ' + translate('navigation.vocabs'),
            ),
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
            onBoxes:
                box.hasVocabs ? () => navigateToAndReload('box', box.id) : null,
            onTest: box.hasVocabs
                ? () => navigateToAndReload('box/test', box.id)
                : null,
            onOptions: () => navigateToAndReload('box/settings', box.id),
            onShare: box.hasVocabs
                ? () => Navigator.pushNamed(
                      context,
                      'box/export',
                      arguments: box,
                    )
                : null,
          ),
        ]),
      );
}
