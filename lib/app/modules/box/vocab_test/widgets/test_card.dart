import 'package:flutter/material.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/widgets/layout_foundation.dart';

class TestCard extends StatelessWidget {
  final int index;
  final void Function() nextPage;
  final Vocab vocab;
  final bool askForeign;
  final bool hasForms;
  final String lang;
  final FocusNode focusNode;

  TestCard(
    this.index,
    this.vocab, {
    this.nextPage,
    this.askForeign = true,
    this.hasForms = true,
    this.lang = 'EN',
    this.focusNode,
  });

  final textController = TextEditingController();
  final formController = TextEditingController();

  void next() {
    if (nextPage != null) nextPage();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Expanded(
          child: LayoutFoundation(
            (EdgeInsets p) => Card(
              margin: p,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Column(
                  children: <Widget>[
                    Spacer(flex: 2),
                    Text(
                      askForeign ? vocab.main : vocab.other,
                      style: TextStyle(fontSize: 32),
                    ),
                    Spacer(),
                    TextField(
                      autofocus: true,
                      focusNode: focusNode,
                      controller: textController,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => hasForms
                          ? FocusScope.of(context).nextFocus()
                          : next(),
                      decoration: InputDecoration(
                        labelText: askForeign ? lang : 'Deutsch',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    if (hasForms)
                      TextField(
                        controller: formController,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => next(),
                        decoration: InputDecoration(
                          labelText: 'Formen',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
        RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          textColor: Colors.white,
          child: Text('Weiter'),
          onPressed: next,
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}
