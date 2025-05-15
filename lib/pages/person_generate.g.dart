// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_generate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonGenerate _$PersonGenerateFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['age']);
  return PersonGenerate(
    firstName: json['firstName'] as String? ?? 'Unknown',
    lastName: json['last_name'] as String,
    age: (json['age'] as num).toInt(),
    hobbies:
        (json['hobbies'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$PersonGenerateToJson(PersonGenerate instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'last_name': instance.lastName,
      'age': instance.age,
      'hobbies': instance.hobbies,
    };
