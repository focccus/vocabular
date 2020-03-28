// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsControllerBase, Store {
  Computed<MaterialColor> _$colorComputed;

  @override
  MaterialColor get color =>
      (_$colorComputed ??= Computed<MaterialColor>(() => super.color)).value;
  Computed<bool> _$isDarkComputed;

  @override
  bool get isDark =>
      (_$isDarkComputed ??= Computed<bool>(() => super.isDark)).value;

  final _$langsAtom = Atom(name: '_SettingsControllerBase.langs');

  @override
  ObservableList<String> get langs {
    _$langsAtom.context.enforceReadPolicy(_$langsAtom);
    _$langsAtom.reportObserved();
    return super.langs;
  }

  @override
  set langs(ObservableList<String> value) {
    _$langsAtom.context.conditionallyRunInAction(() {
      super.langs = value;
      _$langsAtom.reportChanged();
    }, _$langsAtom, name: '${_$langsAtom.name}_set');
  }

  final _$gradesAtom = Atom(name: '_SettingsControllerBase.grades');

  @override
  String get grades {
    _$gradesAtom.context.enforceReadPolicy(_$gradesAtom);
    _$gradesAtom.reportObserved();
    return super.grades;
  }

  @override
  set grades(String value) {
    _$gradesAtom.context.conditionallyRunInAction(() {
      super.grades = value;
      _$gradesAtom.reportChanged();
    }, _$gradesAtom, name: '${_$gradesAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_SettingsControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$_SettingsControllerBaseActionController =
      ActionController(name: '_SettingsControllerBase');

  @override
  void addLang(String lang) {
    final _$actionInfo =
        _$_SettingsControllerBaseActionController.startAction();
    try {
      return super.addLang(lang);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGrade(String grade) {
    final _$actionInfo =
        _$_SettingsControllerBaseActionController.startAction();
    try {
      return super.setGrade(grade);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleDarkMode(bool v) {
    final _$actionInfo =
        _$_SettingsControllerBaseActionController.startAction();
    try {
      return super.toggleDarkMode(v);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setColor(MaterialColor c) {
    final _$actionInfo =
        _$_SettingsControllerBaseActionController.startAction();
    try {
      return super.setColor(c);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeLang(String lang) {
    final _$actionInfo =
        _$_SettingsControllerBaseActionController.startAction();
    try {
      return super.removeLang(lang);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'langs: ${langs.toString()},grades: ${grades.toString()},isLoading: ${isLoading.toString()},color: ${color.toString()},isDark: ${isDark.toString()}';
    return '{$string}';
  }
}
