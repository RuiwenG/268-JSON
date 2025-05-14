class Person {
  String name;
  int age;
  List<String> hobbies;

  Person(this.name, this.age, this.hobbies);

  // Method to convert Person object to a JSON-compatible Map
  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age, 'hobbies': hobbies};
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      json['name'] as String,
      json['age'] as int,
      (json['hobbies'] as List).cast<String>(),
    );
  }

  @override
  String toString() {
    return 'Person{name: $name, age: $age, hobbies: $hobbies}';
  }
}
