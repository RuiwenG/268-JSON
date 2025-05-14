import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:hw5/pages/person.dart';

class ManualSerializationPage extends StatefulWidget {
  const ManualSerializationPage({super.key});

  @override
  _ManualSerializationPageState createState() =>
      _ManualSerializationPageState();
}

class _ManualSerializationPageState extends State<ManualSerializationPage> {
  // Use a List to hold the Person objects
  final List<Person> _people = [
    Person("Alice", 25, ["Reading", "Gaming"]),
    Person("Bob", 30, ["Cooking", "Hiking"]),
  ];
  String _jsonString = ""; // To display the serialized JSON
  String _deserializedString = "";

  // Function to serialize the list of people to JSON
  void _serializePeople() {
    try {
      // Convert each Person object in the list to its JSON representation
      List<Map<String, dynamic>> jsonList =
          _people.map((person) => person.toJson()).toList();
      // Encode the list of JSON representations to a JSON string
      _jsonString = jsonEncode(jsonList);
      setState(() {
        _deserializedString = ""; // Clear any previous deserialization
      });
    } catch (e) {
      _jsonString = "Error: $e";
    }
    setState(() {}); // Update the UI
  }

  // Function to deserialize the JSON string back to a list of Person objects
  void _deserializePeople() {
    if (_jsonString.isEmpty) {
      setState(() {
        _deserializedString =
            "Error: No JSON to deserialize.  Serialize first.";
      });
      return;
    }
    try {
      // Decode the JSON string to a dynamic list.
      final dynamic decodedList = jsonDecode(_jsonString);

      // Check if the decoded data is actually a List.
      if (decodedList is! List) {
        setState(() {
          _deserializedString = "Error: Invalid JSON format. Expected a list.";
        });
        return;
      }
      // Map each element of the list to a Person object, handling potential errors during deserialization.
      List<Person> peopleList =
          decodedList
              .map((item) {
                try {
                  return Person.fromJson(
                    item as Map<String, dynamic>,
                  ); // Cast each item to Map<String, dynamic>
                } catch (e) {
                  // Handle errors during Person.fromJson
                  print(
                    "Error deserializing a Person: $e. Item: $item",
                  ); // Log the error
                  return null; // Or throw an error, or return a default Person
                }
              })
              .whereType<Person>()
              .toList(); //remove null values

      //If the list is empty after filtering nulls, show a message
      if (peopleList.isEmpty) {
        setState(() {
          _deserializedString = "Error: No valid Person objects found in JSON.";
        });
        return;
      }
      _deserializedString = peopleList.toString();
      setState(() {});
    } catch (e) {
      _deserializedString = "Error: $e";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manual JSON Demo'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Person List:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Display the list of people
              Text(_people.toString(), style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _serializePeople,
                child: const Text('Serialize to JSON'),
              ),
              const SizedBox(height: 10),
              // Display the JSON string
              Text(
                'Serialized JSON:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _jsonString,
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _deserializePeople,
                child: const Text('Deserialize from JSON'),
              ),
              const SizedBox(height: 10),
              Text(
                'Deserialized List:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _deserializedString,
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
