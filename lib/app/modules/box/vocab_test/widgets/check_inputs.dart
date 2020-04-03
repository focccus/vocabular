import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../vocab_value.dart';

class CheckInputs extends StatelessWidget {
  final void Function(int) itemSelected;
  final bool hasForms;
  final List<VocabTestValue> values;
  final bool askForeign;

  CheckInputs(
    this.values,
    this.itemSelected, {
    this.hasForms = false,
    this.askForeign = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return ListView(
      padding: w >= 720
          ? EdgeInsets.symmetric(vertical: 32, horizontal: (w - 560) / 2)
          : EdgeInsets.all(16),
      children: <Widget>[
        Text(
          translate('test.check_input'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        ...ListTile.divideTiles(
          context: context,
          color: Theme.of(context).dividerColor,
          tiles: values.map((vocab) {
            final index = values.indexOf(vocab);
            final text = askForeign ? vocab.vocab.main : vocab.vocab.other;
            return ListTile(
              title: Text('$text - ${vocab.input}'),
              subtitle: hasForms ? Text(vocab?.inputForms ?? '') : null,
              onTap: () => itemSelected?.call(index),
            );
          }),
        ),
      ],
    );
  }
}
