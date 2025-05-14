import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hw5/pages/background.dart';
import 'package:hw5/pages/manual.dart'; // For compute

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Serialization Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => const MyHomePage(), // Home page
        '/manual':
            (context) =>
                const ManualSerializationPage(), // Manual serialization page
        '/background':
            (context) =>
                const BackgroundParsingPage(), // Background parsing page
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON Demo Home'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/manual',
                ); // Navigate to manual serialization
              },
              child: const Text('Manual Serialization'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/background',
                ); // Navigate to background parsing
              },
              child: const Text('Background Parsing'),
            ),
          ],
        ),
      ),
    );
  }
}
