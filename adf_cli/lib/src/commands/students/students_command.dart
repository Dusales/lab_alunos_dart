import 'package:args/command_runner.dart';

import '../../repositories/student_dio_repository.dart';
import 'subcommands/delete_by_id.dart';
import 'subcommands/find_all_command.dart';
import 'subcommands/find_by_id.dart';
import 'subcommands/insert_command.dart';
import 'subcommands/update_command.dart';

class StudentsCommand extends Command {
  @override
  String get description => 'Students Operations';

  @override
  String get name => 'students';

  StudentsCommand() {
    final studentsRepository = StudentsDioRepository();
    addSubcommand(FindAllCommand(studentsRepository));
    addSubcommand(FindByIdCommand(studentsRepository));
    addSubcommand(InsertCommand(studentsRepository));
    addSubcommand(UpdateCommand(studentsRepository));
    addSubcommand(DeleteByIdCommand(studentsRepository));
  }
}
