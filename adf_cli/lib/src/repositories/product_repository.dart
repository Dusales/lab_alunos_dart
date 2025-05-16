import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/courses.dart';

class ProductRepository {
  Future<Courses> findByName(String name) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/products?name=$name'),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }

    final responseData = jsonDecode(response.body);

    if (responseData.isEmpty) {
      throw Exception('Produto não encontrado');
    }

    // first-> caso não tenha o primeiro cara retorna erro.
    return Courses.fromMap(responseData.first);
  }
}
