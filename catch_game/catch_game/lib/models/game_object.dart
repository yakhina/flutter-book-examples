import 'package:flutter/material.dart';

class GameObject {
  Offset position;
  double radius;
  double speed;
  Color color;

  GameObject({
    required this.position,
    this.radius = 20,
    this.speed = 3,
    this.color = Colors.orange,
  });

  void fall() {
    // Увеличиваем координату Y — объект "падает"
    position = Offset(position.dx, position.dy + speed);
  }

  bool isOutOfScreen(double screenHeight) {
    return position.dy - radius > screenHeight;
  }
}
