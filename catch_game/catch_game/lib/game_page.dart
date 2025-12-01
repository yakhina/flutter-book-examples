import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'models/game_object.dart';
import 'models/paddle_object.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  Size? screenSize;

  GameObject? ball;
  PaddleObject? paddle;

  // Скорости мяча по осям X и Y
  double ballVx = 0;
  double ballVy = 200;

  // Тикер для обновлений (~60 fps)
  late final Ticker _ticker;

  int score = 0;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();

    _ticker = createTicker(_onTick)..start();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenSize = MediaQuery.of(context).size;

      // Создаём мяч в центре экрана
      ball = GameObject(position: Offset(screenSize!.width / 2, 0), radius: 20, color: Colors.red);

      // Создаём ракетку внизу экрана
      paddle = PaddleObject(
        position: Offset(screenSize!.width / 2 - 50, screenSize!.height - 60),
        width: 100,
        height: 20,
        color: Colors.blueAccent,
      );

      // Задаём случайное начальное направление по X
      final random = Random();
      ballVx = random.nextBool() ? 100 : -100;
    });
  }

  bool circleRectCollision({
    required double cx, // центр круга X
    required double cy, // центр круга Y
    required double radius,
    required Rect rect, // прямоугольник
  }) {
    // Находим ближайшую точку прямоугольника к центру круга
    double closestX = cx.clamp(rect.left, rect.right);
    double closestY = cy.clamp(rect.top, rect.bottom);

    // Вычисляем расстояние между центром круга и этой точкой
    double distanceX = cx - closestX;
    double distanceY = cy - closestY;

    double distanceSquared = distanceX * distanceX + distanceY * distanceY;

    return distanceSquared <= radius * radius;
  }

  void _onTick(Duration elapsed) {
    if (ball == null || screenSize == null || isGameOver) return;

    final dt = 1 / 60.0; // 60 кадров в секунду

    double newX = ball!.position.dx + ballVx * dt;
    double newY = ball!.position.dy + ballVy * dt;

    // Отскок от левых и правых границ
    if (newX <= 0 || newX >= screenSize!.width - ball!.radius * 2) {
      ballVx = -ballVx;
    }

    // Отскок от верхней границы
    if (newY <= 0) {
      ballVy = -ballVy; // меняем направление вниз
    }

    //Проверяем столкновение ракетки и мяча. В случае столкновения увеличиваем счетчки игры и меняем координату Y для отскока
    if (paddle != null &&
        circleRectCollision(
          cx: ball!.position.dx,
          cy: ball!.position.dy,
          radius: ball!.radius,
          rect: paddle!.rect,
        ) &&
        ballVy > 0) {
      ballVy = -ballVy; // отскок вверх
      score += 1;
    }

    // Если мяч ушёл за нижнюю границу — конец игры
    if (newY >= screenSize!.height) {
      isGameOver = true;
      _ticker.stop();
    }

    setState(() {
      ball = GameObject(position: Offset(newX, newY), radius: ball!.radius, color: ball!.color);
    });
  }

  void _resetGame() {
    setState(() {
      score = 0;
      isGameOver = false;

      ball = GameObject(position: Offset(screenSize!.width / 2, 0), radius: 20, color: Colors.red);

      paddle = PaddleObject(
        position: Offset(screenSize!.width / 2 - 50, screenSize!.height - 60),
        width: 100,
        height: 20,
        color: Colors.blueAccent,
      );

      final random = Random();
      ballVx = random.nextBool() ? 100 : -100;
      ballVy = 200;
      _ticker.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (paddle != null && screenSize != null) {
            setState(() {
              paddle!.move(details.delta.dx, screenSize!.width);
            });
          }
        },
        child: Stack(
          children: [
            // Счёт
            Positioned(
              top: 40,
              left: 20,
              child: Text('Счёт: $score', style: const TextStyle(fontSize: 24)),
            ),

            // Мяч
            if (ball != null)
              Positioned(
                left: ball!.position.dx,
                top: ball!.position.dy,
                child: Container(
                  width: ball!.radius,
                  height: ball!.radius,
                  decoration: BoxDecoration(color: ball!.color, shape: BoxShape.circle),
                ),
              ),

            // Ракетка
            if (paddle != null)
              Positioned(
                left: paddle!.position.dx,
                top: paddle!.position.dy,
                child: Container(
                  width: paddle!.width,
                  height: paddle!.height,
                  decoration: BoxDecoration(
                    color: paddle!.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

            // Экран завершения игры
            if (isGameOver)
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Игра окончена',
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(onPressed: _resetGame, child: const Text('Перезапустить')),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
