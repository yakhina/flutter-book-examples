import 'dart:convert';
import 'package:http/http.dart' as http;

/// Сервис геокодинга — получает координаты города по его названию
class GeocodingService {
  /// Возвращает координаты (широту и долготу) по названию города
  ///
  /// [cityName] — название города, введённое пользователем.
  /// Возвращает карту с ключами 'latitude' и 'longitude'.
  /// В случае ошибки (например, город не найден), выбрасывается исключение.
  Future<Map<String, double>> fetchCoordinates(String cityName) async {
    // Формируем URL запроса к API Nominatim (OpenStreetMap)
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search'
      '?q=$cityName&format=json&limit=1',
    );

    // Выполняем GET-запрос с обязательным заголовком User-Agent
    final response = await http.get(
      url,
      headers: {'User-Agent': 'weather_app_example (your_email@example.com)'},
    );

    // Проверяем успешность запроса
    if (response.statusCode == 200) {
      // Декодируем JSON-ответ в список
      final List data = jsonDecode(response.body);

      // Если хотя бы один результат найден — возвращаем координаты
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        return {'latitude': lat, 'longitude': lon};
      } else {
        // Если список пустой — город не найден
        throw Exception('Город не найден');
      }
    } else {
      // Если статус не 200 — ошибка HTTP
      throw Exception('Ошибка геокодинга: ${response.statusCode}');
    }
  }
}
