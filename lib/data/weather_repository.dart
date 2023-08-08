import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tutorial/models/weather.dart';

class WeatherRepository {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather?appid=61d2c2e15f815c8b8b6f02085d0555e5&units=metric&q=';

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse(_baseUrl + cityName));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}