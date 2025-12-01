import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:city_quest/core/di/service_locator.dart';

import 'package:city_quest/features/quest/pages/quest_page.dart';
import 'package:city_quest/features/map/pages/map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidYandexMap.useAndroidViewSurface = false;

  // Все зависимости: Hive, DataSource, Repository, UseCases, BLoC, Pages
  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.lightBlueAccent,
          surface: Colors.blue.shade50,
        ),
      ),
      title: 'Тайны города',
      routes: {'/map': (_) => const MapPage()},
      home: const QuestPage(),
    );
  }
}
