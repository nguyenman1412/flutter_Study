import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tutorial/data/weather_repository.dart';
import 'package:tutorial/models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial())
  {
on<FetchWeather>((event, emit) async {
  try {
    emit(WeatherLoading());

        final weather = await weatherRepository.getWeather(event.cityName);
    emit(WeatherLoaded(cityName: event.cityName, temp: weather.temp.toString()));
      } catch (_) {
        emit(WeatherError());
      }
});
  }
}