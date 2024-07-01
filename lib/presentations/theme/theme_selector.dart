import 'package:flutter/material.dart';

class ThemeSelector extends ChangeNotifier {
  ThemeMode _mode;

  ThemeSelector(this._mode);

  setTheme(ThemeMode m) {
    _mode = m;
    notifyListeners();
  }

  get isLightMode => _mode == ThemeMode.light;

  get mode => _mode;
}
