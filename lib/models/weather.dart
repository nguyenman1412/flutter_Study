class Weather {
  final String cityName;
  final double temp;

  const Weather({required this.cityName, required this.temp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'],
    );
  }
}