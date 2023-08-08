import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial/weather_bloc.dart';
import 'package:tutorial/data/weather_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository = WeatherRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();

  void _fetchWeather() {
    BlocProvider.of<WeatherBloc>(context)
        .add(FetchWeather(_textController.text));
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration:const  InputDecoration(
                hintText: 'Enter a city',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return const Text('Enter a city to get started');
                } else if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text(
                        '${state.cityName} Weather',
                        style:const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const  SizedBox(height: 16),
                      Text(
                        '${state.temp}°C',
                        style:const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return const Text('Failed to load weather data');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}