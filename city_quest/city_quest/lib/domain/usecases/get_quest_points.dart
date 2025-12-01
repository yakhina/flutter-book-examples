import 'package:city_quest/domain/entities/quest_point.dart';
import 'package:city_quest/domain/repositories/city_quests_repository.dart';

class GetQuestPoints {
  final CityQuestsRepository repository;

  GetQuestPoints(this.repository);

  Future<List<QuestPoint>> call() {
    return repository.getQuestPoints();
  }
}
