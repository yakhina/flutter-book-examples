import 'dart:async'; // Подключаем библиотеку для работы с таймерами
import 'package:flutter/material.dart';

// Экран таймера
class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  TimerScreenState createState() => TimerScreenState();
}

// Состояние экрана таймера
class TimerScreenState extends State<TimerScreen> {
  // Оставшееся время (в секундах)
  int _remainingTime = 60;

  // Объект таймера, который будет "тикает" каждую секунду
  Timer? _timer;

  // Флаг, показывающий, работает ли таймер сейчас
  bool _isRunning = false;

  // Запуск таймера
  void _startTimer() {
    if (_isRunning) return; // Если таймер уже работает — ничего не делаем

    _isRunning = true;

    // Запускаем таймер, который срабатывает каждую секунду
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        // Если время ещё не закончилось — уменьшаем его
        setState(() {
          _remainingTime--;
        });
      } else {
        // Если время вышло — останавливаем таймер
        _stopTimer();
      }
    });
  }

  // Остановка таймера
  void _stopTimer() {
    _timer?.cancel(); // Отменяем таймер (если он есть)
    _isRunning = false;
  }

  // Сброс таймера к начальному значению
  void _resetTimer() {
    _stopTimer(); // Сначала остановим таймер
    setState(() {
      _remainingTime = 60; // Установим время обратно на 60 секунд
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Центрируем содержимое по вертикали
      children: [
        // Отображаем оставшееся время
        Text("$_remainingTime сек.", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),

        // Кнопки управления: Старт, Пауза, Сброс
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _startTimer, child: Text("Старт")),
            SizedBox(width: 10),
            ElevatedButton(onPressed: _stopTimer, child: Text("Пауза")),
            SizedBox(width: 10),
            ElevatedButton(onPressed: _resetTimer, child: Text("Сброс")),
          ],
        ),
      ],
    );
  }
}
