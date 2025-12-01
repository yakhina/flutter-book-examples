import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:city_quest/domain/entities/quest_point.dart';

/// Маркер точки квеста.
/// Создаёт CircleMapObject с обработчиком нажатия.
/// onTap — callback, вызываемый при выборе точки.
class QuestMarker {
  static CircleMapObject build(QuestPoint p, void Function(String id) onTap) {
    return CircleMapObject(
      mapId: MapObjectId('quest_${p.id}'),
      // Используем разные цвета для уже заврешенных пользователем точек и обычных
      fillColor: p.isCompleted ? Colors.greenAccent.withAlpha(70) : Colors.redAccent.withAlpha(70),
      strokeColor: p.isCompleted ? Colors.green.withAlpha(90) : Colors.red.withAlpha(90),
      // Обработчик нажатия находится внутри самого маркера
      onTap: (_, __) => onTap(p.id),
      circle: Circle(center: Point(latitude: p.latitude, longitude: p.longitude), radius: p.radius),
    );
  }
}
