import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  final String title;

  TitleDivider(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(title),
        Expanded(
          child: Container(
            height: 1,
            margin: EdgeInsets.only(left: 8),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
