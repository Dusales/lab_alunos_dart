import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/students.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/students_repository.dart';

class InsertCommand extends Command {
  final StudentsRepository studentRepository;
  final productRepository = ProductRepository();

  @override
  String get description => 'Insert Student';

  @override
  String get name => 'insert';

  InsertCommand(this.studentRepository) {
    // fu- constructor
    argParser.addOption('file', help: 'Patch of the csv file', abbr: 'f');
  }

  @override
  Future<void> run() async {
    print('Aguarde ...');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync(); // lista de Strings
    print('----------------------------------');

    for (var student in students) {
      final studentData = student.split(';');
      final courseCsv =
          studentData[2]
              .split(',')
              .map((e) => e.trim())
              .toList(); // map para tirar os espaços do final

      final courseFutures =
          courseCsv.map((c) async {
            final course = await productRepository.findByName(c);
            course.isStudent = true;
            return course;
          }).toList();

      // resolvendo o instance of que é gerado por um await dentro do map
      // assim ele vai esperar todas as requisições e retornar uma lista de cursos.
      final courses = await Future.wait(courseFutures);

      final studentModel = Students(
        name: studentData[0],
        age: int.tryParse(studentData[1]),
        nameCourses: courseCsv,
        courses: courses,
        address: Address(
          street: studentData[3],
          number: int.parse(studentData[4]),
          zipCode: studentData[5],
          city: City(id: 1, name: studentData[6]),
          phone: Phone(ddd: int.parse(studentData[7]), phone: studentData[8]),
        ),
      );

      await studentRepository.insert(studentModel);
    }
    print('--------------------');
    print('Alunos adicionados com sucesso.');
  }
}
