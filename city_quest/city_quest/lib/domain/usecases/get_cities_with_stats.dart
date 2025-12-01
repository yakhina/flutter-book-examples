import 'package:city_quest/domain/entities/city_quest_stats.dart';
import 'package:city_quest/domain/repositories/city_quests_repository.dart';
import 'package:city_quest/data/datasources/city_quests_local_datasource.dart';

class GetCityQuestStats {
  final CityQuestsRepository questRepository;
  final CityQuestsLocalDataSource local;

  GetCityQuestStats({required this.questRepository, required this.local});

  /// Возвращает статистику по ВСЕМ городам:
  /// total — всего квестов в городе
  /// completed — выполнено
  Future<List<CityQuestStats>> call() async {
    final cities = await questRepository.getCities();

    final result = <CityQuestStats>[];

    for (final city in cities) {
      final points = await questRepository.getQuestPointsByCity(city.cityId);

      final total = points.length;
      final completed = points.where((p) => p.isCompleted).length;

      result.add(
        CityQuestStats(cityId: city.cityId, name: city.name, total: total, completed: completed),
      );
    }

    return result;
  }
}
