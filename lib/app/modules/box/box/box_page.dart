import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';
import 'package:vocabular/app/widgets/tabs.dart';
import 'box_controller.dart';

class BoxPage extends StatefulWidget {
  final int id;
  const BoxPage(this.id, {Key key}) : super(key: key);

  @override
  _BoxPageState createState() => _BoxPageState();
}

class _BoxPageState extends ModularState<BoxPage, BoxController>
    with SingleTickerProviderStateMixin {
  //use 'controller' variable to access controller

  TabController tabController;
  TextEditingController textController = TextEditingController();
  TextEditingController formsController = TextEditingController();

  @override
  void initState() {
    if (widget.id == null) return Navigator.pop(context);

    controller.loadBox(widget.id).then((box) {
      tabController = TabController(
        vsync: this,
        initialIndex: controller.selectedCompartment,
        length: controller.com.length,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (controller.isLoading)
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );

        if (controller.selectedCompartment == null)
          return Scaffold(
            appBar: AppBar(),
            body: buildEmpty(),
          );

        return buildLoaded();
      },
    );
  }

  Widget buildEmpty() {
    return Center(
      child: Text(translate('com.empty')),
    );
  }

  Widget buildTabBar() {
    return Observer(
      builder: (_) => CustomTabBar(
        controller.com.map((c) => c.length.toString()).toList(),
        tabController: tabController,
        onSelect: controller.setSelected,
      ),
    );
  }

  double vertPadding = 16;

  Widget buildLoaded() {
    final h = MediaQuery.of(context).size.height;

    vertPadding = h < 380 ? 8 : 16;
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.box.title),
      ),
      body: Column(
        children: <Widget>[
          if (tabController != null) buildTabBar(),
          Expanded(
            child: LayoutFoundation(
              (EdgeInsets p) => Card(
                margin: p.copyWith(top: vertPadding, bottom: vertPadding),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Observer(builder: (context) {
                    switch (controller.vocabState) {
                      case VocabState.loading:
                        {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      case VocabState.loaded:
                        {
                          return checkCard();
                        }
                      case VocabState.checked:
                        {
                          return checkCard();
                        }

                      default:
                        return buildEmpty();
                    }
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget checkCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (controller.currentVocab.beated > 0) ...[
              Text(controller.currentVocab.beated.toString()),
              Icon(Icons.done, color: Colors.greenAccent),
            ],
            SizedBox(
              width: 8,
            ),
            if (controller.currentVocab.failed > 0) ...[
              Text(controller.currentVocab.failed.toString()),
              Icon(Icons.close, color: Colors.red),
            ],
          ],
        ),
        Spacer(),
        Text(
          translate(
            'com.stage',
            args: {
              'num': controller.com.length - controller.selectedCompartment
            },
          ),
          style: TextStyle(fontSize: 20),
        ),
        if (vertPadding >= 16)
          Padding(
            padding: EdgeInsets.all(vertPadding),
            child: Divider(),
          ),
        ...buildContent()
      ],
    );
  }

  List<Widget> buildContent() {
    final ret = <Widget>[
      Text(
        controller.box.askForeign
            ? controller.currentVocabData.main
            : controller.currentVocabData.other,
        style: TextStyle(fontSize: vertPadding * 2),
      ),
      SizedBox(
        height: vertPadding,
      ),
    ];

    final checked = controller.vocabState == VocabState.checked;

    if (controller.box.mustType) {
      void check() {
        controller.checkInputs(textController.text, formsController.text);
      }

      ret.addAll([
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(),
            Expanded(
              flex: 4,
              child: TextField(
                autofocus: true,
                controller: textController,
                enabled: !checked,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => controller.box.hasFormen
                    ? FocusScope.of(context).nextFocus()
                    : check(),
                decoration: InputDecoration(
                  labelText: controller.box.askForeign
                      ? controller.box.lang
                      : translate('lang'),
                  border: OutlineInputBorder(),
                  prefixIcon: checked
                      ? (controller.inputRight
                          ? Icon(Icons.done, color: Colors.green)
                          : Icon(Icons.clear, color: Colors.red))
                      : null,
                ),
              ),
            ),
            SizedBox(
              width: vertPadding,
            ),
            Expanded(
              child: Text(checked
                  ? (controller.box.askForeign
                      ? controller.currentVocabData.other
                      : controller.currentVocabData.main)
                  : ''),
            )
          ],
        ),
        SizedBox(
          height: vertPadding,
        ),
        if (controller.box.hasFormen)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Spacer(),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: formsController,
                  enabled: !checked,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => check(),
                  decoration: InputDecoration(
                    labelText: translate('box.forms'),
                    prefixIcon: checked
                        ? (controller.formsRight
                            ? Icon(Icons.done, color: Colors.green)
                            : Icon(Icons.clear, color: Colors.red))
                        : null,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: vertPadding,
              ),
              Expanded(
                child: Text(
                    checked ? controller.currentVocabData?.forms ?? '' : ''),
              )
            ],
          ),
        Spacer(),
        checked
            ? RaisedButton(
                autofocus: true,
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                child: Text(translate('navigation.continue')),
                textColor: Colors.white,
                onPressed: () {
                  textController.clear();
                  formsController.clear();
                  controller.next(
                    input: controller.inputRight && controller.formsRight,
                    loadNextTab: true,
                    onTabSelected: tabController.animateTo,
                  );
                })
            : RaisedButton.icon(
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                icon: Icon(Icons.search),
                label: Text(translate('com.check')),
                textColor: Colors.white,
                onPressed: check,
              ),
      ]);
    } else {
      // show just the text
      if (checked) {
        ret.addAll([
          Text(
            controller.box.askForeign
                ? controller.currentVocabData.other
                : controller.currentVocabData.main,
          ),
          SizedBox(
            height: vertPadding,
          ),
          Text(
            controller.currentVocabData?.forms ?? '',
            style: TextStyle(color: Colors.grey),
          ),
          Spacer(),
          ButtonBar(
            buttonHeight: 32 + vertPadding,
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton.icon(
                padding: EdgeInsets.symmetric(horizontal: 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                label: Text(''),
                onPressed: () => controller.next(
                  input: false,
                  loadNextTab: true,
                  onTabSelected: tabController.animateTo,
                ),
              ),
              RaisedButton.icon(
                autofocus: true,
                padding: EdgeInsets.symmetric(horizontal: 48),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                icon: Icon(Icons.done),
                label: Text(''),
                onPressed: () => controller.next(
                  input: true,
                  loadNextTab: true,
                  onTabSelected: tabController.animateTo,
                ),
              ),
            ],
          ),
        ]);
      } else {
        ret.addAll([
          Text(''),
          SizedBox(
            height: vertPadding,
          ),
          Text(''),
          Spacer(),
          ButtonBar(
            buttonHeight: 48,
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton.icon(
                autofocus: true,
                padding: EdgeInsets.symmetric(horizontal: 48),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                icon: Icon(Icons.search),
                label: Text(translate('com.check')),
                onPressed: () => controller.vocabState = VocabState.checked,
              ),
            ],
          )
        ]);
      }
    }

    return ret;
  }
}
