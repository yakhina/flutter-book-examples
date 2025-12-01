import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';

@freezed
class City with _$City {
  const factory City({
    required String cityId,
    required String name,
    required double latitude,
    required double longitude,
    required double radius,
  }) = _City;
}
