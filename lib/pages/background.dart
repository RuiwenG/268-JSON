import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Replace with your OpenWeatherMap API key and desired city.
const String apiKey = ''; // <--- Replace with your actual API key
const String city = 'Beijing'; // <--- Change this to your desired city

// Function to fetch weather data from OpenWeatherMap API
Future<WeatherData> fetchWeatherData(http.Client client) async {
  final response = await client.get(
    Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
    ), //Added metric units
  );

  // Use the compute function to run parseWeatherData in a separate isolate.
  return compute(parseWeatherData, response.body);
}

// A function that converts the response body into a WeatherData object.
// This function must be a top-level function to be used with compute().
WeatherData parseWeatherData(String responseBody) {
  final parsed = jsonDecode(responseBody) as Map<String, dynamic>;
  return WeatherData.fromJson(parsed);
}

class WeatherData {
  final String cityName;
  final String description;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final String iconCode; //To get the weather icon.

  WeatherData({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.iconCode,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'] as String,
      description:
          (json['weather'] as List).isNotEmpty
              ? json['weather'][0]['description'] as String
              : 'No description', //Added check for empty list
      temperature: json['main']['temp'] as double,
      feelsLike: json['main']['feels_like'] as double,
      humidity: json['main']['humidity'] as int,
      iconCode:
          (json['weather'] as List).isNotEmpty
              ? json['weather'][0]['icon'] as String
              : '01d',
    );
  }
  String getIconUrl() {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}

class BackgroundParsingPage extends StatefulWidget {
  const BackgroundParsingPage({super.key});
  @override
  _BackgroundParsingPageState createState() => _BackgroundParsingPageState();
}

class _BackgroundParsingPageState extends State<BackgroundParsingPage> {
  late Future<WeatherData> futureWeatherData;

  @override
  void initState() {
    super.initState();
    futureWeatherData = fetchWeatherData(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Data")), // Changed title
      body: Center(
        child: FutureBuilder<WeatherData>(
          future: futureWeatherData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('An error has occurred!\n${snapshot.error}'),
              ); // Display error
            } else if (snapshot.hasData) {
              return WeatherDisplay(weatherData: snapshot.data!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({super.key, required this.weatherData});

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            weatherData.cityName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(weatherData.description, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Image.network(weatherData.getIconUrl()),
          const SizedBox(height: 16),
          Text(
            'Temperature: ${weatherData.temperature}°C',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Feels Like: ${weatherData.feelsLike}°C',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Humidity: ${weatherData.humidity}%',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
