import 'package:dio/dio.dart';

import '../models/students.dart';

class StudentsDioRepository {
  Future<List<Students>> findAll() async {
    try {
      final studentsResult = await Dio().get('http://localhost:8080/students');

      return studentsResult.data.map<Students>((student) {
        return Students.fromMap(student);
      }).toList();
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Students> findById(int id) async {
    try {
      final studentResult = await Dio().get(
        'http://localhost:8080/students/$id',
      );

      if (studentResult.data == null) {
        throw Exception();
      }

      return Students.fromMap(studentResult.data);
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insert(Students student) async {
    // como Dio não tem necessidade de converter usando .toSjon o próprio já se encarrega dessa conversão.
    try {
      await Dio().post('http://localhost:8080/students', data: student.toMap());
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> update(Students student) async {
    try {
      await Dio().put(
        'http://localhost:8080/students/${student.id}',
        data: student.toMap(),
      );
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await Dio().delete('http://localhost:8080/students/$id}');
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }
}
