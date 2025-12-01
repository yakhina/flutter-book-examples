import 'dart:math';
import 'package:city_quest/domain/entities/quest_point.dart';

class IsWithinRadiusResponse {
  bool isWithinRadius;
  double distance;
  IsWithinRadiusResponse({required this.isWithinRadius, required this.distance});
}

class IsWithinRadius {
  const IsWithinRadius();

  IsWithinRadiusResponse call({
    required QuestPoint point,
    required double userLatitude,
    required double userLongitude,
    double? radius, // можно использовать point.radius или передать вручную
  }) {
    final effectiveRadius = radius ?? point.radius;

    final distance = _calculateDistance(
      point.latitude,
      point.longitude,
      userLatitude,
      userLongitude,
    );

    return IsWithinRadiusResponse(isWithinRadius: distance <= effectiveRadius, distance: distance);
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371000; // метры

    final dLat = _deg(lat2 - lat1);
    final dLon = _deg(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg(lat1)) * cos(_deg(lat2)) * sin(dLon / 2) * sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _deg(double deg) => deg * pi / 180;
}
