import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  final void Function() onVocab;
  final void Function() onBoxes;
  final void Function() onTest;
  final void Function() onShare;
  final void Function() onOptions;

  const ActionBar({
    Key key,
    this.onVocab,
    this.onBoxes,
    this.onTest,
    this.onShare,
    this.onOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final small = MediaQuery.of(context).size.width < 480;

    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      buttonHeight: 52.0,
      buttonMinWidth: 64.0,
      children: <Widget>[
        FloatingActionButton(
          mini: small,
          heroTag: null,
          onPressed: onVocab,
          child: Icon(Icons.add),
          elevation: 4,
        ),
        ActionButton(
          onPressed: onBoxes,
          icon: Icons.library_books,
          name: 'Boxen',
          small: small,
        ),
        ActionButton(
          onPressed: onTest,
          icon: Icons.school,
          name: 'Test',
          small: small,
        ),
        ActionButton(
          onPressed: onShare,
          icon: Icons.share,
          name: 'Teilen',
          small: small,
        ),
        ActionButton(
          onPressed: onOptions,
          icon: Icons.settings,
          name: 'Optionen',
          small: small,
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String name;
  final void Function() onPressed;
  final bool small;

  const ActionButton({
    Key key,
    this.icon,
    this.name,
    this.onPressed,
    this.small = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (small)
      return IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        tooltip: name,
      );

    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: onPressed,
      child: Column(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
          ),
          Text(name),
        ],
      ),
    );
  }
}
