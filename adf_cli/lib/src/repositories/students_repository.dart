import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/students.dart';

// implementação dos métodos dos verbos https
class StudentsRepository {
  Future<List<Students>> findAll() async {
    final studentsResult = await http.get(
      Uri.parse('http://localhost:8080/students'),
    );

    if (studentsResult.statusCode != 200) {
      throw Exception();
    }
    // para fazer parse de lista não pode chamar ele diretamente, é preciso fazer o jsonDecode primeiro.
    final studentsData = jsonDecode(studentsResult.body);

    // chama o map e transforma para o objeto que eu quero.
    return studentsData.map<Students>((student) {
      return Students.fromMap(student);
    }).toList();
  }

  Future<Students> findById(int id) async {
    final studentsResult = await http.get(
      Uri.parse('http://localhost:8080/students/$id'),
    );

    if (studentsResult.statusCode != 200) {
      throw Exception();
    }

    if (studentsResult.body == '{}') {
      throw Exception();
    }

    return Students.fromJson(studentsResult.body);
  }

  Future<void> insert(Students student) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/students'),
      body: student.toJson(),
      headers: {
        // no http é importante enviar o content-type: application/json
        'content-type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> update(Students student) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/students/${student.id}'),
      body: student.toJson(),
      headers: {
        // no http é importante enviar o content-type: application/json
        'content-type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:8080/students/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
