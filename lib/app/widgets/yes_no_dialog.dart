import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

Future<bool> showYesNoDialog(BuildContext context, String title,
    {String content}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        FlatButton(
          child: Text(translate('navigation.yes')),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        RaisedButton(
          autofocus: true,
          child: Text(translate('navigation.no')),
          onPressed: () => Navigator.of(context).pop(false),
        )
      ],
    ),
  );
}
