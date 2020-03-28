// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  final _$themeAtom = Atom(name: '_AppControllerBase.theme');

  @override
  MaterialColor get theme {
    _$themeAtom.context.enforceReadPolicy(_$themeAtom);
    _$themeAtom.reportObserved();
    return super.theme;
  }

  @override
  set theme(MaterialColor value) {
    _$themeAtom.context.conditionallyRunInAction(() {
      super.theme = value;
      _$themeAtom.reportChanged();
    }, _$themeAtom, name: '${_$themeAtom.name}_set');
  }

  final _$isDarkAtom = Atom(name: '_AppControllerBase.isDark');

  @override
  bool get isDark {
    _$isDarkAtom.context.enforceReadPolicy(_$isDarkAtom);
    _$isDarkAtom.reportObserved();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.context.conditionallyRunInAction(() {
      super.isDark = value;
      _$isDarkAtom.reportChanged();
    }, _$isDarkAtom, name: '${_$isDarkAtom.name}_set');
  }

  final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase');

  @override
  void setColor(MaterialColor c) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction();
    try {
      return super.setColor(c);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBrightness(bool v) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction();
    try {
      return super.setBrightness(v);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'theme: ${theme.toString()},isDark: ${isDark.toString()}';
    return '{$string}';
  }
}
