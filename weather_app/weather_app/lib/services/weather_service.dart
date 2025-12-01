import 'dart:convert';
import 'package:http/http.dart' as http;

/// Сервис получения погоды с использованием Open-Meteo API
class WeatherService {
  WeatherService();

  /// Загружает текущую погоду по координатам [latitude] и [longitude]
  ///
  /// Возвращает карту с текущими значениями температуры, скорости ветра и погодного кода.
  /// В случае ошибки выбрасывает исключение.
  Future<Map<String, dynamic>> fetchCurrentWeather(double latitude, double longitude) async {
    // Формируем URL запроса к Open-Meteo API
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,wind_speed_10m'
      '&timezone=auto',
    );

    // Отправляем GET-запрос
    final response = await http.get(url);

    // Если запрос успешный (код 200), парсим JSON и возвращаем данные
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['current'];
    } else {
      // В случае ошибки — выбрасываем исключение
      throw Exception('Не удалось загрузить данные о погоде');
    }
  }
}
