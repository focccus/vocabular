import 'package:flutter/cupertino.dart';

class LayoutFoundation extends StatelessWidget {
  final Widget Function(EdgeInsets) builder;

  LayoutFoundation(this.builder);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final w = size.maxWidth;
        return builder(
          w >= 720
              ? EdgeInsets.symmetric(vertical: 32, horizontal: (w - 560) / 2)
              : EdgeInsets.all(16),
        );
      },
    );
  }
}
