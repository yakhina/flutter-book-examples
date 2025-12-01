import 'package:flutter/material.dart';

import 'timer_screen.dart';
import 'stopwatch_screen.dart';

void main() {
  // Точка входа в приложение. Здесь вызывается основной виджет приложения.
  runApp(TimerApp());
}

// Корневой виджет приложения
class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Убираем баннер "debug" в углу экрана
      debugShowCheckedModeBanner: false,

      // Устанавливаем базовую цветовую тему приложения
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),

      // Задаём главный экран приложения — виджет с вкладками
      home: TimerStopwatchApp(),
    );
  }
}

// Основной экран приложения с вкладками "Таймер" и "Секундомер"
class TimerStopwatchApp extends StatefulWidget {
  const TimerStopwatchApp({super.key});

  @override
  TimerStopwatchAppState createState() => TimerStopwatchAppState();
}

class TimerStopwatchAppState extends State<TimerStopwatchApp> with SingleTickerProviderStateMixin {
  // Контроллер, который управляет переключением вкладок
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    // Инициализируем контроллер с двумя вкладками
    // vsync: this — для оптимизации анимаций, требуется миксин SingleTickerProviderStateMixin
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Обязательно освобождаем ресурсы контроллера при уничтожении экрана
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Верхняя панель с заголовком
      appBar: AppBar(title: Text("Таймер и секундомер")),

      // Здесь отображаются два экрана: таймер и секундомер
      // Пользователь может перелистывать между ними свайпами
      body: TabBarView(
        controller: _tabController,
        children: [
          TimerScreen(), // Первый экран — таймер
          StopwatchScreen(), // Второй экран — секундомер
        ],
      ),

      // Нижняя панель с вкладками, по которым можно нажимать
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(icon: Icon(Icons.timer), text: "Таймер"),
          Tab(icon: Icon(Icons.watch), text: "Секундомер"),
        ],
      ),
    );
  }
}
