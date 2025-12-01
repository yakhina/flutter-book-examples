import 'package:flutter/material.dart';
import 'package:shopping_list/utils/settings_repository.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = SettingsRepository.getThemeMode();

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await SettingsRepository.setThemeMode(mode);
    notifyListeners(); // уведомляем все виджеты о смене темы
  }
}
