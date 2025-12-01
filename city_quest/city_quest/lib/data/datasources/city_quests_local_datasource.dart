import 'package:city_quest/data/models/city_model.dart';
import 'package:hive/hive.dart';
import 'package:city_quest/data/models/quest_point_model.dart';

class CityQuestsLocalDataSource {
  final Box<QuestPointModel> questsBox;
  final Box<CityModel> citiesBox;

  CityQuestsLocalDataSource(this.questsBox, this.citiesBox);

  Future<List<QuestPointModel>> getPoints() async {
    return questsBox.values.toList();
  }

  Future<void> savePoints(List<QuestPointModel> points) async {
    await questsBox.clear();
    await questsBox.addAll(points);
  }

  Future<void> markCompleted(String id) async {
    final index = questsBox.values.toList().indexWhere((e) => e.id == id);
    if (index == -1) return;

    final updated = QuestPointModel(
      id: questsBox.getAt(index)!.id,
      title: questsBox.getAt(index)!.title,
      description: questsBox.getAt(index)!.description,
      latitude: questsBox.getAt(index)!.latitude,
      longitude: questsBox.getAt(index)!.longitude,
      radius: questsBox.getAt(index)!.radius,
      isCompleted: true,
      cityId: questsBox.getAt(index)!.cityId,
    );

    await questsBox.putAt(index, updated);
  }

  Future<List<CityModel>> getCities() async {
    return citiesBox.values.toList();
  }

  Future<CityModel?> getCity(String id) async {
    return citiesBox.values.firstWhere((c) => c.cityId == id);
  }

  Future<void> saveCities(List<CityModel> cities) async {
    await citiesBox.clear();
    await citiesBox.addAll(cities);
  }

  Future<void> addCities(List<CityModel> cities) async {
    await citiesBox.addAll(cities);
  }

  bool isCityBoxEmpty() => citiesBox.isEmpty;
}
