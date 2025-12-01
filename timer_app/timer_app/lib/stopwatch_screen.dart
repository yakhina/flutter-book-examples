import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Экран секундомера
class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  StopwatchScreenState createState() => StopwatchScreenState();
}

// Состояние экрана секундомера
class StopwatchScreenState extends State<StopwatchScreen> with SingleTickerProviderStateMixin {
  // Ticker нужен для периодического вызова функции каждый кадр (примерно 60 раз в секунду)
  late Ticker _ticker;

  // Хранит прошедшее время
  Duration _elapsed = Duration.zero;

  // Флаг — запущен ли секундомер
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();

    // Инициализируем тикер, который при каждом "тике" вызывает _onTick
    _ticker = Ticker(_onTick);
  }

  // Эта функция вызывается каждый раз при "тике" (новом кадре)
  void _onTick(Duration elapsed) {
    setState(() {
      _elapsed = elapsed; // Обновляем отображаемое время
    });
  }

  // Запуск секундомера
  void _startStopwatch() {
    if (!_isRunning) {
      _ticker.start(); // Запускаем тикер
      _isRunning = true; // Обновляем состояние
    }
  }

  // Пауза секундомера
  void _stopStopwatch() {
    if (_isRunning) {
      _ticker.stop(); // Останавливаем тикер
      _isRunning = false; // Обновляем состояние
    }
  }

  // Сброс секундомера
  void _resetStopwatch() {
    _ticker.stop(); // Останавливаем тикер
    setState(() {
      _elapsed = Duration.zero; // Обнуляем время
      _isRunning = false;
    });
  }

  // Форматируем время в строку вида мм:сс:мс
  String _formatTime(Duration duration) {
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String milliseconds = (duration.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(
      2,
      '0',
    );
    return "$minutes:$seconds:$milliseconds";
  }

  @override
  void dispose() {
    // Обязательно освобождаем ресурсы тикера, когда экран удаляется
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Центрируем содержимое по вертикали
      children: [
        // Отображаем текущее время
        Text(_formatTime(_elapsed), style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),

        // Кнопки управления: Старт, Пауза, Сброс
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _startStopwatch, child: Text("Старт")),
            SizedBox(width: 10),
            ElevatedButton(onPressed: _stopStopwatch, child: Text("Пауза")),
            SizedBox(width: 10),
            ElevatedButton(onPressed: _resetStopwatch, child: Text("Сброс")),
          ],
        ),
      ],
    );
  }
}
