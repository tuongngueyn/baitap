import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class Weather {
  final String description;
  final double temperature;
  final double humidity;
  final double windSpeed;
  final IconData weatherIcon;

  Weather({
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherIcon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      weatherIcon: _getWeatherIcon(json['weather'][0]['description']),
    );
  }

  static IconData _getWeatherIcon(String description) {
    if (description.contains('nắng')) {
      return Icons.wb_sunny;
    } else if (description.contains('mây')) {
      return Icons.cloud;
    } else if (description.contains('mưa')) {
      return Icons.beach_access;
    } else {
      return Icons.wb_cloudy;
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Weather _weather;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      const apiKey = '4cba0058b7fff73af70f44530e9e4302';
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=London&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final weather = Weather.fromJson(decodedData);
        setState(() {
          _weather = weather;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Không thể tải dữ liệu thời tiết';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Có lỗi xảy ra: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ứng dụng thời tiết'),
        ),
        body: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : _errorMessage.isNotEmpty
            ? Center(child: Text(_errorMessage))
            : WeatherDisplay(weather: _weather),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final Weather? weather;

  const WeatherDisplay({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: weather != null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dự báo thời tiết',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Icon(
                    weather!.weatherIcon,
                    size: 150,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  weather!.description,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  '${weather!.temperature}°C',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Độ ẩm: ${weather!.humidity}%',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Tốc độ gió: ${weather!.windSpeed} m/s',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ],
            )
                : Text(
              'Không có dữ liệu thời tiết',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
