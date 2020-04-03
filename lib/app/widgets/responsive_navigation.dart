import 'package:flutter/material.dart';

const _tabletBreakpoint = 720.0;
const _desktopBreakpoint = 1440.0;
const _minHeight = 400.0;
const _drawerWidth = 304.0;

class ResponsiveNavigation extends StatelessWidget {
  final FloatingActionButton floatingActionButton;
  final int currentIndex;
  final Widget body;
  final Widget appBar;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> tabs;
  final WidgetBuilder drawerHeaderBuilder, drawerFooterBuilder;
  final Color bottomNavigationBarColor;
  final double tabletBreakpoint, desktopBreakpoint, minHeight, drawerWidth;
  final BottomNavigationBarType bottomNavigationBarType;
  final Color bottomNavigationBarSelectedColor,
      bottomNavigationBarUnselectedColor;
  final bool isDense;

  const ResponsiveNavigation({
    Key key,
    @required this.currentIndex,
    @required this.tabs,
    @required this.onTap,
    this.isDense = false,
    this.floatingActionButton,
    this.drawerFooterBuilder,
    this.drawerHeaderBuilder,
    this.body,
    this.appBar,
    this.bottomNavigationBarColor,
    this.tabletBreakpoint = _tabletBreakpoint,
    this.desktopBreakpoint = _desktopBreakpoint,
    this.drawerWidth = _drawerWidth,
    this.bottomNavigationBarType = BottomNavigationBarType.fixed,
    this.bottomNavigationBarSelectedColor,
    this.bottomNavigationBarUnselectedColor,
    this.minHeight = _minHeight,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: LayoutBuilder(
        builder: (_, dimens) {
          final _direction = Directionality.of(context);
          final isRtl = _direction == TextDirection.rtl;
          if (dimens.maxWidth >= desktopBreakpoint &&
              dimens.maxHeight > minHeight) {
            return Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: _drawerWidth,
                        child: _buildDrawer(context, true),
                      ),
                      Expanded(
                        child: Scaffold(
                          appBar: appBar,
                          body: body,
                        ),
                      ),
                    ],
                  ),
                  if (floatingActionButton != null) ...[
                    Positioned(
                      top: drawerHeaderBuilder != null
                          ? (kToolbarHeight + 116)
                          : (kToolbarHeight + 16),
                      right: isRtl ? _drawerWidth - 32 : null,
                      left: !isRtl ? _drawerWidth - 32 : null,
                      child: floatingActionButton,
                      // width: 50,
                      // height: 50,
                    )
                  ],
                ],
              ),
            );
          }
          if (dimens.maxWidth >= tabletBreakpoint &&
              dimens.maxHeight > minHeight) {
            return Scaffold(
              appBar: appBar,
              drawer: drawerHeaderBuilder != null || drawerFooterBuilder != null
                  ? _buildDrawer(context, false)
                  : null,
              body: Row(
                children: <Widget>[
                  NavigationRail(
                    elevation: 1,
                    extended: false,
                    selectedIconTheme: IconThemeData(
                      color: Theme.of(context).accentColor,
                      opacity: 1,
                    ),
                    selectedLabelTextStyle: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    labelType: NavigationRailLabelType.all,
                    leading: floatingActionButton,
                    onDestinationSelected: onTap,
                    selectedIndex: currentIndex,
                    destinations: tabs
                        .map(
                          (tab) => NavigationRailDestination(
                            icon: tab.icon,
                            label: tab.title,
                          ),
                        )
                        .toList(),
                  ),
                  Expanded(child: body),
                ],
              ),
            );
          }
          return Scaffold(
            appBar: appBar,
            drawer: drawerHeaderBuilder != null || drawerFooterBuilder != null
                ? _buildDrawer(context, false)
                : null,
            body: body,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            bottomNavigationBar: BottomNavigationBar(
              type: bottomNavigationBarType,
              backgroundColor: bottomNavigationBarColor,
              currentIndex: currentIndex,
              onTap: onTap,
              items: tabs,
              unselectedItemColor: bottomNavigationBarUnselectedColor,
              selectedItemColor: bottomNavigationBarSelectedColor,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, bool showTabs) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (drawerHeaderBuilder != null) ...[
                drawerHeaderBuilder(context),
              ],
              if (showTabs) ...[
                for (var tab in tabs) ...[
                  ListTile(
                    dense: isDense,
                    selected: currentIndex == tabs.indexOf(tab),
                    leading: tab?.icon,
                    title: tab?.title,
                    onTap: () => onTap(tabs.indexOf(tab)),
                  ),
                ]
              ],
              if (drawerFooterBuilder != null) ...[
                drawerFooterBuilder(context),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
