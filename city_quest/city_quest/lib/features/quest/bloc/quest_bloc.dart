import 'package:city_quest/domain/entities/city_quest_stats.dart';
import 'package:city_quest/domain/usecases/get_cities_with_stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:city_quest/domain/usecases/get_quest_points.dart';
import 'package:city_quest/domain/usecases/get_points_within_radius.dart';
import 'package:city_quest/domain/entities/quest_point.dart';

part 'quest_event.dart';
part 'quest_state.dart';

class QuestBloc extends Bloc<QuestEvent, QuestState> {
  final GetQuestPoints getAllPoints;
  final GetPointsWithinRadius getNearbyPoints;
  final GetCityQuestStats getCityStats;

  QuestBloc({required this.getAllPoints, required this.getNearbyPoints, required this.getCityStats})
    : super(QuestInitial()) {
    on<QuestLoadRequested>(_onLoad);
    on<QuestRefreshNearby>(_onRefreshNearby);
    on<QuestLoadCities>(_onLoadCities);
  }

  List<QuestPoint> _all = [];
  List<QuestPoint> _nearby = [];
  List<CityQuestStats> _cities = [];

  Future<void> _onLoad(QuestLoadRequested event, Emitter<QuestState> emit) async {
    emit(QuestLoading());

    try {
      _all = await getAllPoints();

      final completed = _all.where((p) => p.isCompleted).length;
      final total = _all.length;

      emit(QuestLoaded(allPoints: _all, completed: completed, total: total));
    } catch (_) {
      emit(QuestError("Не удалось загрузить квест"));
    }
  }

  Future<void> _onRefreshNearby(QuestRefreshNearby event, Emitter<QuestState> emit) async {
    try {
      _nearby = await getNearbyPoints(
        userLatitude: event.lat,
        userLongitude: event.lon,
        radiusMeters: 5000,
      );

      emit(QuestNearbyUpdated(points: _nearby));
    } catch (_) {
      // На данном этапе в UI это можно игнорировать — это вспомогательные данные
      // Но для реальных проектов стоит реализовать обработку,
      // логирование и вывод таких ошибок для пользователя
    }
  }

  // Cтатистика по городам
  Future<void> _onLoadCities(QuestLoadCities event, Emitter<QuestState> emit) async {
    try {
      _cities = await getCityStats();
      emit(QuestCitiesLoaded(_cities));
    } catch (_) {
      emit(QuestError("Не удалось загрузить города"));
    }
  }
}
