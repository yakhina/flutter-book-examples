import 'package:city_quest/data/datasources/city_quests_local_datasource.dart';
import 'package:city_quest/domain/entities/city.dart';
import 'package:city_quest/domain/entities/quest_point.dart';
import 'package:city_quest/domain/repositories/city_quests_repository.dart';

class CityQuestsRepositoryImpl implements CityQuestsRepository {
  final CityQuestsLocalDataSource local;

  CityQuestsRepositoryImpl(this.local);

  @override
  Future<List<QuestPoint>> getQuestPoints() async {
    final models = await local.getPoints();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<List<QuestPoint>> getQuestPointsByCity(String cityId) async {
    // 1) Получаем все модели из локальной БД
    final models = await local.getPoints();

    // 2) Фильтруем здесь, на уровне репозитория
    final filtered = models.where((m) => m.cityId == cityId);

    // 3) Преобразуем в доменные сущности
    return filtered.map((m) => m.toDomain()).toList();
  }

  @override
  Future<void> markPointCompleted(String id) async {
    return local.markCompleted(id);
  }

  @override
  Future<List<City>> getCities() async {
    final models = await local.getCities();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<City?> getCity(String cityId) async {
    final model = await local.getCity(cityId);
    return model?.toDomain();
  }
}
