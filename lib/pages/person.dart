class Person {
  String name;
  int age;
  // List<String> hobbies;

  Person(
    this.name,
    this.age,
    // this.hobbies
  );

  // Method to convert Person object to a JSON-compatible Map
  Map<String, dynamic> toJson() {
    return {
      'name': name, 'age': age,
      // 'hobbies': hobbies
    };
  }

  Person.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      age = json['age'] as int;

  // @override
  // String toString() {
  //   // return 'Person{name: $name, age: $age, }';
  // }
}
