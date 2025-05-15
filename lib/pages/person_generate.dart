import 'package:json_annotation/json_annotation.dart';

part 'person_generate.g.dart';

@JsonSerializable()
class PersonGenerate {
  @JsonKey(defaultValue: 'Unknown')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(required: true)
  final int age;

  final List<String> hobbies;

  PersonGenerate({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.hobbies,
  });

  factory PersonGenerate.fromJson(Map<String, dynamic> json) =>
      _$PersonGenerateFromJson(json);

  Map<String, dynamic> toJson() => _$PersonGenerateToJson(this);

  @override
  String toString() {
    return 'PersonGenerate{firstName: $firstName, lastName: $lastName, age: $age, hobbies: $hobbies}';
  }
}
