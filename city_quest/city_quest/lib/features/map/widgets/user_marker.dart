import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class UserMarker {
  static CircleMapObject build(Point p) {
    return CircleMapObject(
      zIndex: 3,
      mapId: const MapObjectId('user_point'),
      fillColor: Colors.lightBlueAccent,
      strokeColor: Colors.blueAccent,
      circle: Circle(center: p, radius: 50),
    );
  }
}
