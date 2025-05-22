import 'package:args/command_runner.dart';
import 'dart:io';

import '../../../repositories/student_dio_repository.dart';

class DeleteByIdCommand extends Command {
  final StudentsDioRepository studentRepository;

  @override
  String get description => 'Delete Student By Id';

  @override
  String get name => 'delete';

  DeleteByIdCommand(this.studentRepository) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    // Verifica se o ID foi informado corretamente
    if (argResults?['id'] == null) {
      print('por favor envie o id do aluno com o comando --id=0 ou -i 0');
      return;
    }

    // Converte o valor para inteiro (int?) usando tryParse, se falhar, retorna null
    final id = int.tryParse(argResults?['id']);

    if (id == null) {
      print('ID inválido. Use um número inteiro.');
      return;
    }

    print('Aguarde buscando dados...');
    final student = await studentRepository.findById(id);
    // ignore: unnecessary_null_comparison
    if (student == null) {
      print('Aluno não encontrado com o ID $id.');
      return;
    }

    print(''' 

    Você está prestes a deletar o aluno:
    ID: ${student.id}
    Nome: ${student.name}
    Cursos: ${student.courses.map((c) => c.name).join(', ')}
    ''');
    print('-----------------');

    print('Digite S para sim ou N para não deletar o aluno.');
    var confirmDelete = stdin.readLineSync();

    if (confirmDelete?.toLowerCase().trim() == 's') {
      await studentRepository.deleteById(id);
      print('Aluno deletado com sucesso!');
    } else {
      print('Operação cancelada');
    }
  }
}
