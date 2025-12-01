import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

class SettingsRepository {
  static const _boxName = 'settings';
  static const _themeModeKey = 'theme_mode';
  static const _categoryColorsKey = 'category_colors';

  static Box get _box => Hive.box(_boxName);

  // Тема приложения: светлая, тёмная или системная
  static ThemeMode getThemeMode() {
    final value = _box.get(_themeModeKey, defaultValue: 'system');
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    await _box.put(_themeModeKey, mode.name);
  }

  // Цвета категорий (хранятся как int)
  static Map<String, int> getCategoryColors() {
    final map = Map<String, int>.from(_box.get(_categoryColorsKey, defaultValue: {}));
    return map;
  }

  static Future<void> setCategoryColor(String category, Color color) async {
    final colors = getCategoryColors();
    colors[category] = color.value;
    await _box.put(_categoryColorsKey, colors);
  }
}
