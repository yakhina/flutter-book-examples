import 'package:flutter/material.dart';
import 'services/geocoding_service.dart';
import 'services/weather_service.dart';

void main() {
  runApp(const WeatherApp()); // Точка входа: запускаем виджет приложения
}

// Основной виджет приложения
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Погода по городу',
      theme: ThemeData(
        useMaterial3: true, // Используем дизайн Material 3
        colorSchemeSeed: Colors.blue, // Основной цвет темы
      ),
      home: const WeatherScreen(), // Указываем главный экран
    );
  }
}

// Состояние экрана с вводом города и отображением погоды
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Контроллер для текстового поля (ввод города)
  final _cityController = TextEditingController();

  // Сервисы геокодинга и погоды
  final _geoService = GeocodingService();
  final _weatherService = WeatherService();

  // Переменные состояния UI
  String? _temperature; // температура в градусах
  String? _windspeed; // скорость ветра
  bool _isLoading = false; // индикатор загрузки
  String? _error; // сообщение об ошибке

  // Метод загрузки погоды по введённому городу
  Future<void> _loadWeather() async {
    setState(() {
      // Показываем индикатор загрузки, сбрасываем прошлые значения
      _isLoading = true;
      _error = null;
      _temperature = null;
      _windspeed = null;
    });

    try {
      // Получаем координаты города
      final coords = await _geoService.fetchCoordinates(_cityController.text);

      // Получаем данные о погоде по координатам
      final weather = await _weatherService.fetchCurrentWeather(
        coords['latitude']!,
        coords['longitude']!,
      );

      // Обновляем UI с полученными значениями
      setState(() {
        _temperature = weather['temperature_2m'].toString();
        _windspeed = weather['wind_speed_10m'].toString();
      });
    } catch (e) {
      // Обрабатываем и отображаем ошибку (например, "Город не найден")
      setState(() {
        _error = 'Ошибка: ${e.toString().replaceFirst('Exception: ', '')}';
      });
    } finally {
      // В любом случае отключаем индикатор загрузки
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Погода по городу')), // Заголовок экрана
      body: Padding(
        padding: const EdgeInsets.all(16), // Отступы вокруг содержимого
        child: Column(
          children: [
            // Поле ввода города
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'Введите город'),
            ),
            const SizedBox(height: 16),
            // Кнопка запроса погоды
            ElevatedButton(onPressed: _loadWeather, child: const Text('Показать погоду')),
            const SizedBox(height: 24),
            // Индикатор загрузки
            if (_isLoading) const CircularProgressIndicator(),
            // Сообщение об ошибке, если есть
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            // Отображение температуры и ветра
            if (_temperature != null && _windspeed != null)
              Column(
                children: [
                  Text('Температура: $_temperature °C'),
                  Text('Скорость ветра: $_windspeed км/ч'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
