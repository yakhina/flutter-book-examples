import 'package:flutter/material.dart';

class PaddleObject {
  Offset position;
  double width;
  double height;
  double speed;
  Color color;

  PaddleObject({
    required this.position,
    this.width = 100,
    this.height = 20,
    this.speed = 5,
    this.color = Colors.blueAccent,
  });

  // Метод для перемещения ракетки по горизонтали с ограничениями по ширине экрана
  void move(double deltaX, double screenWidth) {
    double newX = position.dx + deltaX;
    newX = newX.clamp(0, screenWidth - width);
    position = Offset(newX, position.dy);
  }

  // Границы ракетки для проверки столкновений и ограничений
  Rect get rect => Rect.fromLTWH(position.dx, position.dy, width, height);
}
