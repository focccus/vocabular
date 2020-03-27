import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;

  final TabController tabController;

  final void Function(int) onSelect;

  CustomTabBar(this.tabs, {this.tabController, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: LayoutBuilder(builder: (_, layout) {
        final w = layout.maxWidth;

        var p = w / tabs.length * 0.89;
        if (p < 100) p = 100;

        final res = TabBar(
          controller: tabController,
          onTap: onSelect,
          isScrollable: true,
          tabs: tabs
              .map(
                (e) => Tab(
                  child: Container(
                    width: p,
                    alignment: Alignment.center,
                    child: Text(
                      e,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              )
              .toList(),
        );

        if (tabController == null)
          return DefaultTabController(length: tabs.length, child: res);

        return res;
      }),
    );
  }
}
