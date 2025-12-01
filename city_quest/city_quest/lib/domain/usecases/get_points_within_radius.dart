import 'package:city_quest/domain/entities/quest_point.dart';
import 'package:city_quest/domain/usecases/is_within_radius.dart';
import 'package:city_quest/domain/repositories/city_quests_repository.dart';

class GetPointsWithinRadius {
  final CityQuestsRepository repository;
  final IsWithinRadius isWithinRadius;

  GetPointsWithinRadius({required this.repository, required this.isWithinRadius});

  /// Возвращает только те точки, которые находятся в пределах заданного радиуса.
  Future<List<QuestPoint>> call({
    required double userLatitude,
    required double userLongitude,
    required double radiusMeters,
  }) async {
    final allPoints = await repository.getQuestPoints();

    return allPoints.where((point) {
      return isWithinRadius(
        point: point,
        userLatitude: userLatitude,
        userLongitude: userLongitude,
        radius: radiusMeters,
      ).isWithinRadius;
    }).toList();
  }
}
