import 'package:city_quest/data/models/city_model.dart';
import 'package:city_quest/domain/usecases/get_cities_with_stats.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:city_quest/data/models/quest_point_model.dart';
import 'package:city_quest/data/datasources/city_quests_local_datasource.dart';
import 'package:city_quest/data/repositories/city_quests_repository_impl.dart';

import 'package:city_quest/domain/repositories/city_quests_repository.dart';
import 'package:city_quest/domain/usecases/get_quest_points.dart';
import 'package:city_quest/domain/usecases/get_points_within_radius.dart';
import 'package:city_quest/domain/usecases/complete_point.dart';
import 'package:city_quest/domain/usecases/is_within_radius.dart';

import 'package:city_quest/features/quest/bloc/quest_bloc.dart';
import 'package:city_quest/features/map/bloc/map_bloc.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// Service Locator — центральная точка, через которую приложение
/// получает доступ к зависимостям (репозиториям, use case и BLoC).
/// Паттерн Service Locator упрощает архитектуру и помогает
/// централизованно управлять созданием и жизненным циклом объектов.
/// Реализация основана на пакете get_it.
final GetIt serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  // ------------------------------------------------------------
  // Инициализация локального хранилища Hive
  // ------------------------------------------------------------
  // Здесь приложение регистрирует адаптер модели и открывает коробку,
  // чтобы далее использовать её в качестве источника данных.
  await Hive.initFlutter();
  Hive.registerAdapter(QuestPointModelAdapter());
  Hive.registerAdapter(CityModelAdapter());
  final Box<CityModel> citesBox = await Hive.openBox<CityModel>('quest_cities');
  await seedInitialCities(citesBox);
  final Box<QuestPointModel> questsBox = await Hive.openBox<QuestPointModel>('quest_points');
  await seedInitialQuestPoints(questsBox);

  // ------------------------------------------------------------
  // Слой данных (Data Layer)
  // ------------------------------------------------------------
  // DataSource отвечает за работу с конкретным источником данных.
  // Repository объединяет доступ к данным и предоставляет удобный API
  // для доменной логики.
  serviceLocator.registerLazySingleton<CityQuestsLocalDataSource>(
    () => CityQuestsLocalDataSource(questsBox, citesBox),
  );

  serviceLocator.registerLazySingleton<CityQuestsRepository>(
    () => CityQuestsRepositoryImpl(serviceLocator<CityQuestsLocalDataSource>()),
  );

  // ------------------------------------------------------------
  // Доменный уровень (Use Cases)
  // ------------------------------------------------------------
  // Сценарии использования инкапсулируют бизнес-логику и работают
  // только через репозиторий. Каждый use case — самостоятельный
  // объект, выполняющий ровно одну операцию.
  serviceLocator.registerLazySingleton<GetQuestPoints>(
    () => GetQuestPoints(serviceLocator<CityQuestsRepository>()),
  );

  serviceLocator.registerLazySingleton<IsWithinRadius>(() => const IsWithinRadius());

  serviceLocator.registerLazySingleton<GetCityQuestStats>(
    () => GetCityQuestStats(
      questRepository: serviceLocator<CityQuestsRepository>(),
      local: serviceLocator<CityQuestsLocalDataSource>(),
    ),
  );

  serviceLocator.registerLazySingleton<GetPointsWithinRadius>(
    () => GetPointsWithinRadius(
      repository: serviceLocator<CityQuestsRepository>(),
      isWithinRadius: serviceLocator<IsWithinRadius>(),
    ),
  );

  serviceLocator.registerLazySingleton<CompletePoint>(
    () => CompletePoint(serviceLocator<CityQuestsRepository>()),
  );

  // ------------------------------------------------------------
  // Слой управления состоянием (BLoC)
  // ------------------------------------------------------------
  // BLoC создаются как factory, потому что они должны быть
  // независимыми и пересоздаваемыми для разных экранов.
  // Каждый BLoC получает только те use case, которые ему нужны.
  serviceLocator.registerFactory<QuestBloc>(
    () => QuestBloc(
      getAllPoints: serviceLocator<GetQuestPoints>(),
      getNearbyPoints: serviceLocator<GetPointsWithinRadius>(),
      getCityStats: serviceLocator<GetCityQuestStats>(),
    ),
  );

  serviceLocator.registerFactory<MapBloc>(
    () => MapBloc(
      getAllPoints: serviceLocator<GetQuestPoints>(),
      getPointsWithinRadius: serviceLocator<GetPointsWithinRadius>(),
      completePoint: serviceLocator<CompletePoint>(),
      isWithinRadius: serviceLocator<IsWithinRadius>(),
    ),
  );
}

//Заполняем Hive Box начальными данными городов из заранее подготовленного json файла
Future<void> seedInitialCities(Box<CityModel> box) async {
  // Если уже есть точки — ничего не делаем
  if (box.isNotEmpty) {
    return;
  }

  // Загружаем JSON из assets
  final String rawJson = await rootBundle.loadString('assets/mocks/cities.json');
  final List<dynamic> list = json.decode(rawJson);

  // Конвертируем Map → QuestPointModel
  final cities =
      list.map((item) {
        return CityModel(
          cityId: item['cityId'] as String,
          name: item['name'] as String,
          latitude: (item['latitude'] as num).toDouble(),
          longitude: (item['longitude'] as num).toDouble(),
          radius: (item['radius'] as num).toDouble(),
        );
      }).toList();

  // Сохраняем в Hive
  await box.addAll(cities);
}

//Заполняем Hive Box начальными данными из заранее подготовленного json файла
Future<void> seedInitialQuestPoints(Box<QuestPointModel> box) async {
  // Если уже есть точки — ничего не делаем
  if (box.isNotEmpty) {
    return;
  }

  // Загружаем JSON из assets
  final String rawJson = await rootBundle.loadString('assets/mocks/quests.json');
  final List<dynamic> list = json.decode(rawJson);

  // Конвертируем Map → QuestPointModel
  final points =
      list.map((item) {
        return QuestPointModel(
          id: item['id'] as String,
          title: item['title'] as String,
          description: item['description'] as String,
          latitude: (item['latitude'] as num).toDouble(),
          longitude: (item['longitude'] as num).toDouble(),
          radius: (item['radius'] as num).toDouble(),
          isCompleted: item['isCompleted'] as bool,
          cityId: item['cityId'] as String,
        );
      }).toList();

  // Сохраняем в Hive
  await box.addAll(points);
}
