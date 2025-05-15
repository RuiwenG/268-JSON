import 'package:flutter/material.dart';
import 'package:hw5/pages/person_generate.dart';

class CodeGeneratePage extends StatefulWidget {
  const CodeGeneratePage({super.key});

  @override
  State<CodeGeneratePage> createState() => _CodeGenerateState();
}

class _CodeGenerateState extends State<CodeGeneratePage> {
  final List<Map<String, dynamic>> _jsonList = [
    // Normal Json
    {
      'firstName': 'Jane',
      'last_name': 'Smith',
      'age': 25,
      'hobbies': ['Painting', 'Traveling'],
    },
    // firstName Unknown
    {
      'first_name': 'Jane',
      'last_name': 'Smith',
      'age': 25,
      'hobbies': ['Painting', 'Traveling'],
    },
    // firstName Unknown
    {
      'last_name': 'Smith',
      'age': 25,
      'hobbies': ['Painting', 'Traveling'],
    },
    // Not Working, required age
    {
      'first_name': 'Jane',
      'last_name': 'Smith',
      // 'age': 25,
      'hobbies': ['Painting', 'Traveling'],
    },
    // Not Working, required hobbies
    {
      'first_name': 'Jane',
      'last_name': 'Smith',
      'age': 25,
      // 'hobbies': ['Painting', 'Traveling'],
    },
  ];

  List<PersonGenerate?> _personList = [];
  String _displayText = 'Raw JSON Data:';
  String _deserializedString = "";

  @override
  void initState() {
    super.initState();
    // Initial display of raw JSON data
    String rawJsonString = _jsonList.map((json) => json.toString()).join('\n');
    _displayText = 'Raw JSON Data:\n$rawJsonString';
  }

  void _deserializePerson() {
    List<PersonGenerate?> tempList = [];
    for (var json in _jsonList) {
      try {
        PersonGenerate p = PersonGenerate.fromJson(json);
        tempList.add(p);
      } catch (e) {
        debugPrint("Error deserializing JSON: $e");
        tempList.add(null); // Add null for failed deserialization
      }
    }
    _personList = tempList; // Update the main list
    setState(() {
      if (_personList.isNotEmpty) {
        _deserializedString = _personList
            .map((p) => p?.toString() ?? 'null')
            .join('\n\n');
      } else {
        _deserializedString = 'No Person objects to display.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Generated Json Demo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _displayText,
                style: const TextStyle(fontSize: 18), // Use a monospace font
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _deserializePerson,
                child: const Text(
                  'Serialize to JSON',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Deserialized List:',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _deserializedString,
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
