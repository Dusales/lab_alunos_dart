import 'package:args/command_runner.dart';
import '../../../repositories/student_dio_repository.dart';

import 'dart:io';

class FindAllCommand extends Command {
  final StudentsDioRepository repository;

  @override
  String get description => 'Find all Students'; // descrição

  @override
  String get name => 'findAll'; // nome do comando que vai responder por esse cara

  FindAllCommand(this.repository);

  @override
  Future<void> run() async {
    print('Aguarde buscando alunos...');
    final students = await repository.findAll();
    print('Apresentar também os cursos? (S ou N)');
    final showCourses = stdin.readLineSync();

    print('---------------------------');
    print('Alunos:');
    print('---------------------------');
    for (var student in students) {
      if (showCourses?.toLowerCase() == 's') {
        print(
          '${student.id} - ${student.name} ${student.courses.where((course) => course.isStudent).map((e) => e.name).toList()}',
        );
      } else {
        print('${student.id} - ${student.name}');
      }
    }
  }
}
