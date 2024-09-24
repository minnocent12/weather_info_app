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

  // Function to simulate fetching weather data
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 120, 166, 246),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 245, 243, 244),
                backgroundColor: const Color.fromARGB(255, 3, 159, 24),
              ),
              onPressed: _fetchWeather,
              child: const Text('Fetch Weather'),
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
          ],
        ),
      ),
    );
  }
}
