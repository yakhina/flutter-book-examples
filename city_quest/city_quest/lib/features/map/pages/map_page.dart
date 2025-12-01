import 'dart:async';

import 'package:city_quest/features/map/widgets/zoom_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:city_quest/features/map/bloc/map_bloc.dart';
import 'package:city_quest/features/map/widgets/quest_marker.dart';
import 'package:city_quest/features/map/widgets/user_marker.dart';

import 'package:city_quest/services/location/location_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _locationService = const LocationService();
  late final MapBloc bloc;
  List<MapObject> mapObjects = <MapObject>[];
  List<CircleMapObject> placeMarkers = <CircleMapObject>[];
  late CircleMapObject userMarker;

  YandexMapController? controller;
  StreamSubscription? locationSub;
  bool mapReady = false;
  BitmapDescriptor? userIcon;
  BitmapDescriptor? placeIcon;

  @override
  void initState() {
    super.initState();
    bloc = GetIt.instance<MapBloc>();
    _initLocationUpdates();
    bloc.add(MapLoadPointsRequested());
  }

  @override
  void dispose() {
    locationSub?.cancel();
    super.dispose();
  }

  Future<void> _initLocationUpdates() async {
    final allowed = await _locationService.checkPermission();
    if (!allowed) return;

    final pos = await _locationService.getCurrentPosition();
    bloc.add(MapUpdateUserPosition(pos.latitude, pos.longitude));

    locationSub = _locationService.getPositionStream().listen((pos) {
      bloc.add(MapUpdateUserPosition(pos.latitude, pos.longitude));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text("Квесты рядом с вами")),
        body: BlocConsumer<MapBloc, MapState>(
          listener: (context, state) {
            if (state is MapPointDetails) {
              _showPointBottomSheet(context, state);
            }
            if (state is MapReady) {
              _updatePlacemarks(context, state);
            }
          },
          builder: (context, state) {
            if (state is MapLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MapError) {
              return Center(child: Text('Ошибка: ${state.message}'));
            }

            if (state is MapReady) {
              for (final p in state.points) {
                CircleMapObject place = QuestMarker.build(
                  p,
                  (id) => bloc.add(MapPointSelected(id)),
                );
                placeMarkers.add(place);
                mapObjects.add(place);
              }

              if (state.userPoint != null) {
                _moveToUser(state.userPoint!.latitude, state.userPoint!.longitude);
                userMarker = UserMarker.build(state.userPoint!);
                mapObjects.add(userMarker);
              }
            }
            return Stack(
              children: [
                YandexMap(
                  key: const ValueKey("main_map"),
                  mapObjects: mapObjects,
                  zoomGesturesEnabled: true,
                  onMapCreated: (c) {
                    controller = c;
                    mapReady = true;
                  },
                ),
                // Кнопки масштаба
                Positioned(right: 16, bottom: 80, child: MapZoomControls(controller: controller)),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _moveToUser(double lat, double lon) async {
    try {
      if (controller == null || !mapReady) return;

      await controller!.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: Point(latitude: lat, longitude: lon)),
        ),
        animation: const MapAnimation(type: MapAnimationType.smooth, duration: 0.8),
      );
    } catch (_) {}
  }

  void _updatePlacemarks(BuildContext context, MapReady state) {
    mapObjects.clear();
    for (final p in state.points) {
      CircleMapObject place = QuestMarker.build(p, (id) => bloc.add(MapPointSelected(id)));
      placeMarkers.add(place);
      mapObjects.add(place);
    }

    if (state.userPoint != null) {
      _moveToUser(state.userPoint!.latitude, state.userPoint!.longitude);
      userMarker = UserMarker.build(state.userPoint!);
      mapObjects.add(userMarker);
    }
    setState(() {
      mapObjects = mapObjects;
    });
  }

  void _showPointBottomSheet(BuildContext context, MapPointDetails state) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.point.description,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(state.point.title, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              if (state.distance != null)
                Text('Расстояние: ${state.distance!.toStringAsFixed(1)} м')
              else
                const Text('Нет данных о позиции пользователя'),
              const SizedBox(height: 16),
              if (state.canComplete)
                ElevatedButton(
                  onPressed: () {
                    bloc.add(MapCompletePoint(state.point.id));
                    Navigator.pop(context);
                  },
                  child: const Text('Завершить точку'),
                )
              else
                const Text('Вы вне зоны доступности'),
            ],
          ),
        );
      },
    );
  }
}
