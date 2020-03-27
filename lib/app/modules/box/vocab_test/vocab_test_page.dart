import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/widgets/linear_percent_indicator.dart';
import 'package:vocabular/app/widgets/yes_no_dialog.dart';
import 'vocab_test_controller.dart';
import 'widgets/check_inputs.dart';
import 'widgets/test_card.dart';

class VocabTestPage extends StatefulWidget {
  final int id;
  const VocabTestPage(this.id, {Key key}) : super(key: key);

  @override
  _VocabTestPageState createState() => _VocabTestPageState();
}

class _VocabTestPageState
    extends ModularState<VocabTestPage, VocabTestController> {
  //use 'controller' variable to access controller

  PageController pageController = PageController();

  List<FocusNode> focusNodes = [];

  List<TestCard> cards = [];

  @override
  void initState() {
    if (widget.id == null) return Navigator.pop(context);

    controller.loadBox(widget.id).then((value) {
      focusNodes = List.generate(controller.length, (index) => FocusNode());

      cards = controller.vocabs.map(
        (vocab) {
          final index = controller.vocabs.indexOf(vocab);
          return TestCard(
            index,
            vocab.vocab,
            focusNode: focusNodes[index],
            hasForms: controller.box.hasFormen,
            askForeign: controller.box.askForeign,
            lang: controller.box.lang,
            nextPage: () {
              animateTo(index + 1, focus: true);
            },
          );
        },
      ).toList();
    });
    pageController.addListener(() {
      if (pageController.page.round() > controller.selectedPage ||
          pageController.page.round() < controller.selectedPage) {
        if (controller.selectedPage < controller.length) {
          // save the current value
          final card = cards[controller.selectedPage];
          controller.applyAnswer(
            controller.selectedPage,
            card.textController.text,
            card.formController.text,
          );
        }
        controller.selectedPage = pageController.page.round();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    focusNodes.forEach((element) => element.dispose());
    super.dispose();
  }

  void animateTo(int i, {bool focus = true}) {
    pageController.animateToPage(
      i,
      duration: Duration(milliseconds: 600),
      curve: Curves.ease,
    );
    if (focus && i < focusNodes.length) {
      focusNodes[i].requestFocus();
    }
  }

  void confirm() {
    Navigator.of(context).popAndPushNamed(
      '/box/test/${widget.id}/results',
      arguments: controller.vocabs,
    );
  }

  Future<bool> canPop() {
    return showYesNoDialog(
      context,
      'Willst du den Test wirklich abbrechen?',
    );
  }

  Widget buildLoaded() {
    return Column(
      children: <Widget>[
        Observer(
          builder: (context) {
            if (controller.selectedPage < controller.length)
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LinearPercentIndicator(
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                        '${controller.selectedPage + 1} von ${controller.length}'),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.format_list_bulleted),
                    onPressed: () =>
                        pageController.jumpToPage(controller.length),
                  ),
                  animation: true,
                  animationDuration: 200,
                  animateFromLastPercent: true,
                  lineHeight: 12.0,
                  progressColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.grey.shade200,
                  percent: (controller.selectedPage + 1) / controller.length,
                ),
              );
            return Container();
          },
        ),
        Expanded(
          child: PageView(controller: pageController, children: [
            ...cards,
            Observer(builder: (context) {
              return CheckInputs(
                controller.vocabs,
                animateTo,
                askForeign: controller.box.askForeign,
                hasForms: controller.box.hasFormen,
              );
            })
          ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: canPop,
      child: Observer(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('test'),
          ),
          floatingActionButton: controller.length > 0 &&
                  controller.selectedPage == controller.length
              ? FloatingActionButton.extended(
                  icon: Icon(Icons.done),
                  label: Text('Abgeben'),
                  onPressed: confirm,
                )
              : null,
          body: controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : buildLoaded(),
        ),
      ),
    );
  }
}
