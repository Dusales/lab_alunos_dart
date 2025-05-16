import 'dart:convert';

class Courses {
  final int id;
  final String name;
  bool isStudent;

  Courses({required this.id, required this.name, required this.isStudent});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'isStudent': isStudent};
  }

  String toJson() => jsonEncode(toMap());

  // recebe uma string, transforma em um mapa e chama o nosso fromMap
  factory Courses.fromMap(Map<String, dynamic> map) {
    return Courses(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      isStudent: map['isStudent'] ?? false,
    );
  }

  factory Courses.fromJson(String json) => Courses.fromJson(jsonEncode(json));

  // static Students fromMap(coursesMap) {}
}
