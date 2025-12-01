part of 'map_bloc.dart';

sealed class MapEvent {
  const MapEvent();
}

/// Загрузка всех точек квеста
class MapLoadPointsRequested extends MapEvent {
  const MapLoadPointsRequested();
}

/// Обновление позиции пользователя
class MapUpdateUserPosition extends MapEvent {
  final double lat;
  final double lon;

  const MapUpdateUserPosition(this.lat, this.lon);
}

/// Пользователь нажал на точку на карте
class MapPointSelected extends MapEvent {
  final String id;

  const MapPointSelected(this.id);
}

/// Завершение точки из BottomSheet
class MapCompletePoint extends MapEvent {
  final String id;

  const MapCompletePoint(this.id);
}
