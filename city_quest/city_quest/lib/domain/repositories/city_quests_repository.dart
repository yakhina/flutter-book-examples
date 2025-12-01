import 'package:city_quest/domain/entities/city.dart';
import 'package:city_quest/domain/entities/quest_point.dart';

abstract interface class CityQuestsRepository {
  Future<List<QuestPoint>> getQuestPoints();
  Future<List<QuestPoint>> getQuestPointsByCity(String cityId);
  Future<void> markPointCompleted(String id);
  Future<List<City>> getCities();
  Future<City?> getCity(String cityId);
}
