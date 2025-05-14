import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart'; // For compute

class BackgroundParsingPage extends StatefulWidget {
  const BackgroundParsingPage({super.key});

  @override
  _BackgroundParsingPageState createState() => _BackgroundParsingPageState();
}

class _BackgroundParsingPageState extends State<BackgroundParsingPage> {
  String _backgroundResult = "";
  bool _isParsing = false;

  // Function to simulate parsing JSON in the background using compute
  Future<void> _parseJsonInBackground() async {
    setState(() {
      _isParsing = true;
      _backgroundResult = "Parsing...";
    });

    // Simulate a more complex JSON string (replace with your actual JSON)
    const String complexJson = """
    [
      {"name": "John", "age": 30, "city": "New York"},
      {"name": "Jane", "age": 25, "city": "Los Angeles"},
      {"name": "Bob", "age": 40, "city": "Chicago"},
      {"name": "Alice", "age": 22, "city": "San Francisco"},
      {"name": "Mike", "age": 35, "city": "Houston"}
    ]
    """;

    // Use compute to run the parsing in a separate isolate
    try {
      final List<dynamic> result = await compute(
        _parseAndDecodeJson,
        complexJson,
      );
      setState(() {
        _backgroundResult = "Parsed ${result.length} objects in background.";
      });
    } catch (e) {
      setState(() {
        _backgroundResult = "Error parsing JSON: $e";
      });
    }

    setState(() {
      _isParsing = false;
    });
  }

  // This function will be run in a separate isolate by the compute function.
  // It MUST be a top-level function (not a class method or anonymous function).
  static List<dynamic> _parseAndDecodeJson(String jsonString) {
    return jsonDecode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Parsing'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed:
                  _isParsing
                      ? null
                      : _parseJsonInBackground, // Disable button while parsing
              child: Text(
                _isParsing ? 'Parsing...' : 'Parse JSON in Background',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Result:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _backgroundResult,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
