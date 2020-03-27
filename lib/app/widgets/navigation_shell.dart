import 'package:flutter/material.dart';
import 'package:navigation_rail/navigation_rail.dart' as nv;

const _tabletBreakpoint = 720.0;
const _desktopBreakpoint = 1440.0;

class NavigationShell extends StatelessWidget {
  final int currentPage;
  final FloatingActionButton smallActionButton;
  final FloatingActionButton bigActionButton;
  final Widget child;

  NavigationShell(
    this.currentPage,
    this.child, {
    this.smallActionButton,
    this.bigActionButton,
  });

  @override
  Widget build(BuildContext context) {
    var a = bigActionButton ?? smallActionButton;

    if (bigActionButton != null && smallActionButton != null) {
      final w = MediaQuery.of(context).size.width;
      if (w >= _tabletBreakpoint) a = smallActionButton;
    }

    return SafeArea(
      child: nv.NavigationRail(
        currentIndex: currentPage,
        onTap: (val) {
          if (val != currentPage) {
            switch (val) {
              case 1:
                {
                  Navigator.of(context).popAndPushNamed('/vocabs');
                  break;
                }
              case 2:
                {
                  Navigator.of(context).popAndPushNamed('/settings');
                  break;
                }

              default:
                Navigator.of(context).popAndPushNamed('/');
            }
          }
        },
        drawerHeaderBuilder: (c) => UserAccountsDrawerHeader(
          accountName: Text('Vocabular'),
          accountEmail: Text('The ultimate tool to learn vocabs'),
        ),
        drawerFooterBuilder: (c) => Align(
          alignment: Alignment.bottomCenter,
          child: Text('Copyright 2020 focccus'),
        ),
        body: child,
        floatingActionButton: a,
        tabs: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("Boxen"),
            icon: Icon(Icons.folder_open),
          ),
          BottomNavigationBarItem(
            title: Text("Vokabeln"),
            icon: Icon(Icons.language),
          ),
          BottomNavigationBarItem(
            title: Text("Optionen"),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
