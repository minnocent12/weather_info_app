import 'dart:math'; // Import the math library for generating random numbers
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = '';
  String _temperature = '--';
  String _weatherCondition = '--';
  List<Map<String, String>> _sevenDayForecast = [];

  // Function to simulate fetching current weather data
  void _fetchWeather() {
    setState(() {
      _cityName = _cityController.text;

      // Generate a random temperature between 15°C and 30°C
      Random random = Random();
      int temp = 15 + random.nextInt(16); // (30 - 15 + 1) = 16

      _temperature = '$temp°C';

      // Randomly select a weather condition
      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
      _weatherCondition = conditions[random.nextInt(3)];
    });
  }

  // Function to simulate fetching 7-day weather forecast data
  void _fetchSevenDayForecast() {
    setState(() {
      _cityName = _cityController.text;

      // Clear previous forecast
      _sevenDayForecast = [];

      // Randomly generate weather data for the next 7 days
      Random random = Random();
      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];

      for (int i = 1; i <= 7; i++) {
        int temp = 15 + random.nextInt(16); // Temperature between 15°C and 30°C
        String condition = conditions[random.nextInt(3)]; // Random condition
        _sevenDayForecast.add({
          'day': 'Day $i',
          'temperature': '$temp°C',
          'condition': condition,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 120, 166, 246),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 245, 243, 244),
                    backgroundColor: const Color.fromARGB(255, 3, 159, 24),
                  ),
                  onPressed: _fetchWeather,
                  child: const Text('Fetch Weather'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: _fetchSevenDayForecast,
                  child: const Text('7-Day Forecast'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'City: $_cityName',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Temperature: $_temperature',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Condition: $_weatherCondition',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            if (_sevenDayForecast.isNotEmpty) ...[
              const Text(
                '7-Day Weather Forecast:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              for (var dayForecast in _sevenDayForecast)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(
                      dayForecast['condition'] == 'Sunny'
                          ? Icons.wb_sunny
                          : dayForecast['condition'] == 'Cloudy'
                              ? Icons.wb_cloudy
                              : Icons.beach_access, // Rainy icon
                      color: Colors.blue,
                    ),
                    title: Text(dayForecast['day']!),
                    subtitle: Text(
                        'Temperature: ${dayForecast['temperature']}, Condition: ${dayForecast['condition']}'),
                  ),
                ),
            ]
          ],
        ),
      ),
    );
  }
}
