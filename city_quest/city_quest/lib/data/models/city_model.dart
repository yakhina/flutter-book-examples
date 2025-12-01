import 'package:city_quest/domain/entities/city.dart';
import 'package:hive/hive.dart';

part 'city_model.g.dart';

@HiveType(typeId: 2)
class CityModel {
  @HiveField(0)
  final String cityId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  @HiveField(4)
  final double radius;

  const CityModel({
    required this.cityId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  // Преобразование в доменную модель
  factory CityModel.fromDomain(City city) {
    return CityModel(
      cityId: city.cityId,
      name: city.name,
      latitude: city.latitude,
      longitude: city.longitude,
      radius: city.radius,
    );
  }

  // Создание модели из доменной сущности
  City toDomain() {
    return City(
      cityId: cityId,
      name: name,
      latitude: latitude,
      longitude: longitude,
      radius: radius,
    );
  }
}
