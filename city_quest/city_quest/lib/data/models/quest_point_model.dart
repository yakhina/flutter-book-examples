import 'package:hive/hive.dart';
import 'package:city_quest/domain/entities/quest_point.dart';

part 'quest_point_model.g.dart';

@HiveType(typeId: 1)
class QuestPointModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double latitude;

  @HiveField(4)
  final double longitude;

  @HiveField(5)
  final double radius;

  @HiveField(6)
  final bool isCompleted;

  @HiveField(7)
  final String cityId;

  const QuestPointModel({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.isCompleted,
    required this.cityId,
  });

  // Преобразование в доменную модель
  QuestPoint toDomain() {
    return QuestPoint(
      id: id,
      title: title,
      description: description,
      latitude: latitude,
      longitude: longitude,
      radius: radius,
      isCompleted: isCompleted,
      cityId: cityId,
    );
  }

  // Создание модели из доменной сущности
  factory QuestPointModel.fromDomain(QuestPoint point) {
    return QuestPointModel(
      id: point.id,
      title: point.title,
      description: point.description,
      latitude: point.latitude,
      longitude: point.longitude,
      radius: point.radius,
      isCompleted: point.isCompleted,
      cityId: point.cityId,
    );
  }
}
