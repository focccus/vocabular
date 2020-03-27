import 'package:flutter/material.dart';
import 'package:language_pickers/languages.dart';

class LanguageTile extends StatelessWidget {
  final Language lang;
  final void Function() onLongPress;

  LanguageTile(this.lang, {this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(lang.isoCode.toUpperCase()),
      ),
      onLongPress: onLongPress,
      title: Text(lang.name),
    );
  }
}
