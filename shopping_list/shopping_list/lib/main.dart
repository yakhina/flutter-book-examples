import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/viewmodels/theme_notifier.dart';
import 'package:shopping_list/models/shopping_item.dart';
import 'package:shopping_list/views/shopping_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Hive
  await Hive.initFlutter();

  // Регистрируем адаптер,
  // сгенерерированный автоматически
  // через hive_generator
  Hive.registerAdapter(ShoppingItemAdapter());

  // Открываем box для хранения элементов
  await Hive.openBox<ShoppingItem>('items');

  // Открываем box для хранения настроек пользователя
  await Hive.openBox('settings');

  runApp(ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  // Новая переменная для настройки визуальной темы в приложении
  final ThemeMode? themeMode;
  const MyApp({super.key, this.themeMode});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'Список покупок',
      theme: ThemeData(
        useMaterial3: true, // включаем Material Design 3
        colorSchemeSeed: Colors.teal, // задаём базовый цвет темы
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.dark,
      ),
      // Применяем переменную themeMode, сохраненную в настройках пользователя и внутри Hive
      themeMode: themeNotifier.themeMode,
      debugShowCheckedModeBanner: false,
      home: const ShoppingListPage(),
    );
  }
}
