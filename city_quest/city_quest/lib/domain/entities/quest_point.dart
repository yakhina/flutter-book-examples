import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quest_point.freezed.dart';

@freezed
abstract class QuestPoint with _$QuestPoint {
  const factory QuestPoint({
    required String id,
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    required double radius,
    required String cityId,
    @Default(false) bool isCompleted,
  }) = _QuestPoint;
}
