part of 'weather_bloc.dart';

abstract class WeatherState{
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState{}

class WeatherLoading extends WeatherState{}

class WeatherLoaded extends WeatherState {
  final String cityName;
  final String temp;

  const WeatherLoaded({
   required this.cityName,
   required this.temp,
});

  @override
  List<Object> get props => [cityName, temp];

}

class WeatherError extends WeatherState{}