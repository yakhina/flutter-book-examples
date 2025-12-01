import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:city_quest/domain/entities/quest_point.dart';
import 'package:city_quest/domain/usecases/get_quest_points.dart';
import 'package:city_quest/domain/usecases/get_points_within_radius.dart';
import 'package:city_quest/domain/usecases/complete_point.dart';
import 'package:city_quest/domain/usecases/is_within_radius.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetQuestPoints getAllPoints;
  final GetPointsWithinRadius getPointsWithinRadius;
  final CompletePoint completePoint;
  final IsWithinRadius isWithinRadius;

  MapBloc({
    required this.getAllPoints,
    required this.getPointsWithinRadius,
    required this.completePoint,
    required this.isWithinRadius,
  }) : super(const MapInitial()) {
    on<MapLoadPointsRequested>(_onLoadAllPoints);
    on<MapUpdateUserPosition>(_onUpdateUserPosition);
    on<MapPointSelected>(_onPointSelected);
    on<MapCompletePoint>(_onCompletePoint);
  }

  List<QuestPoint> _allPoints = [];
  List<QuestPoint> _visiblePoints = [];
  Point? _userPoint;

  // 1. Загрузка всех точек при старте
  Future<void> _onLoadAllPoints(MapLoadPointsRequested event, Emitter<MapState> emit) async {
    emit(const MapLoading());

    try {
      _allPoints = await getAllPoints();
      _visiblePoints = _allPoints;

      emit(MapReady(points: _visiblePoints, userPoint: _userPoint));
    } catch (e) {
      emit(MapError(e.toString()));
    }
  }

  // 2. Обновление позиции пользователя + фильтрация точек
  Future<void> _onUpdateUserPosition(MapUpdateUserPosition event, Emitter<MapState> emit) async {
    _userPoint = Point(latitude: event.lat, longitude: event.lon);

    try {
      _visiblePoints = await getPointsWithinRadius(
        userLatitude: event.lat,
        userLongitude: event.lon,
        radiusMeters: 5000,
      );

      emit(MapReady(points: _visiblePoints, userPoint: _userPoint));
    } catch (e) {
      emit(MapError(e.toString()));
    }
  }

  // 3. Выбор точки на карте (открытие BottomSheet)
  void _onPointSelected(MapPointSelected event, Emitter<MapState> emit) {
    final point = _allPoints.firstWhere((p) => p.id == event.id);

    if (_userPoint == null) {
      emit(MapPointDetails(point: point, distance: null, canComplete: false));
      return;
    }

    // Логика расчета, находится ли пользователь "в радиусе 150 метров"
    final isWithinRadiusData = isWithinRadius(
      point: point,
      userLatitude: _userPoint!.latitude,
      userLongitude: _userPoint!.longitude,
      //В дальнейшем, можно хранить минимальное расстояние до точки как константу
      //или передавать как переменную, если логика будет меняться
      radius: 150,
    );
    final canComplete = isWithinRadiusData.isWithinRadius;

    emit(
      MapPointDetails(
        point: point,
        distance: isWithinRadiusData.distance,
        canComplete: canComplete,
      ),
    );
  }

  // 4. Завершение точки
  Future<void> _onCompletePoint(MapCompletePoint event, Emitter<MapState> emit) async {
    await completePoint(event.id);

    _allPoints = await getAllPoints();

    emit(MapReady(points: _visiblePoints, userPoint: _userPoint));
  }
}
