part of 'quest_bloc.dart';

sealed class QuestState {
  const QuestState();
}

class QuestInitial extends QuestState {
  const QuestInitial();
}

class QuestLoading extends QuestState {
  const QuestLoading();
}

class QuestLoaded extends QuestState {
  final List<QuestPoint> allPoints;
  final int completed;
  final int total;

  const QuestLoaded({required this.allPoints, required this.completed, required this.total});
}

class QuestNearbyUpdated extends QuestState {
  final List<QuestPoint> points;
  const QuestNearbyUpdated({required this.points});
}

class QuestError extends QuestState {
  final String message;
  const QuestError(this.message);
}

class QuestCitiesLoaded extends QuestState {
  final List<CityQuestStats> cities;
  const QuestCitiesLoaded(this.cities);
}
