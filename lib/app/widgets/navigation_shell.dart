import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vocabular/app/widgets/responsive_navigation.dart';

const _tabletBreakpoint = 720.0;

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
      child: ResponsiveNavigation(
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
          accountEmail: Text(translate('desc')),
        ),
        drawerFooterBuilder: (c) => Container(
          alignment: Alignment.bottomCenter,
          child: Text('Copyright 2020 focccus'),
        ),
        body: child,
        floatingActionButton: a,
        tabs: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text(translate('navigation.boxes')),
            icon: Icon(Icons.folder_open),
          ),
          BottomNavigationBarItem(
            title: Text(translate('navigation.vocabs')),
            icon: Icon(Icons.language),
          ),
          BottomNavigationBarItem(
            title: Text(translate('navigation.settings')),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
