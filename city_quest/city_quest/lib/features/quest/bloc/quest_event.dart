part of 'quest_bloc.dart';

sealed class QuestEvent {
  const QuestEvent();
}

/// Загрузка всех точек квеста
class QuestLoadRequested extends QuestEvent {
  const QuestLoadRequested();
}

/// Обновление списка ближайших точек
class QuestRefreshNearby extends QuestEvent {
  final double lat;
  final double lon;

  const QuestRefreshNearby({required this.lat, required this.lon});
}

/// Загрузка городов
class QuestLoadCities extends QuestEvent {
  const QuestLoadCities();
}
