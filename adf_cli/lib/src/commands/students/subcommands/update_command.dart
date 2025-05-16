import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/students.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/students_repository.dart';

class UpdateCommand extends Command {
  StudentsRepository studentRepository;
  final productRepository = ProductRepository();

  @override
  String get description => 'Update Student';

  @override
  String get name => 'update';

  UpdateCommand(this.studentRepository) {
    argParser.addOption('file', help: 'Patch of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'Student ID', abbr: 'i');
  }

  @override
  Future<void> run() async {
    print('Aguarde ...');
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Por favor informe o id do aluno com o comando --id=0 ou -i 0');
      return;
    }

    final students = File(filePath).readAsLinesSync(); // lista de Strings
    print('Aguarde, atualizando dados do aluno...');
    print('----------------------------------');

    if (students.length > 1) {
      print('Por favor informe somente um aluno no arquivo $filePath');
      return;
    } else if (students.isEmpty) {
      print('Por favor informe um aluno no arquivo $filePath');
    }

    var student = students.first;

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
      id: int.parse(id),
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

    await studentRepository.update(studentModel);

    print('--------------------');
    print('Aluno atualizado sucesso.');
  }
}
