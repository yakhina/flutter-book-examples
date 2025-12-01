import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_quest_stats.freezed.dart';

@freezed
class CityQuestStats with _$CityQuestStats {
  const factory CityQuestStats({
    required String cityId,
    required String name,
    required int total,
    required int completed,
  }) = _CityQuestStats;
}
