import 'package:city_quest/domain/repositories/city_quests_repository.dart';

class CompletePoint {
  final CityQuestsRepository repository;

  CompletePoint(this.repository);

  Future<void> call(String id) {
    return repository.markPointCompleted(id);
  }
}
