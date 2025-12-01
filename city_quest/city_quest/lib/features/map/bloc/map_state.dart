part of 'map_bloc.dart';

sealed class MapState {
  const MapState();
}

/// Начальное состояние
class MapInitial extends MapState {
  const MapInitial();
}

/// Загрузка данных
class MapLoading extends MapState {
  const MapLoading();
}

/// Карта готова к отображению
class MapReady extends MapState {
  final List<QuestPoint> points;
  final Point? userPoint;

  const MapReady({required this.points, required this.userPoint});
}

/// Детальная информация о выбранной точке
class MapPointDetails extends MapState {
  final QuestPoint point;
  final double? distance; // теперь nullable
  final bool canComplete;

  const MapPointDetails({required this.point, required this.distance, required this.canComplete});
}

/// Ошибка
class MapError extends MapState {
  final String message;

  const MapError(this.message);
}
