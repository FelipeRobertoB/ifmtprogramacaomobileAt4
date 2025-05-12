import 'package:myapp/components/tarefa.dart';
import 'package:myapp/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TarefaDao {
  Future<List<Tarefa>> findAll() async {
    // print('Buscando as tarefas no banco de dados');

    final db = await getDataBase();

    
    final List<Map<String, Object?>> tarefaMaps = await db.query(
      'tasks',
      columns: ['title', 'datatarefa', 'horatarefa', 'createdAt'],
    );

    

    final List<Tarefa> tarefaList = [];
    for (final {
          'title': title as String,
          'datatarefa': datatarefa as String,
          'horatarefa': horatarefa as String,
          'createdAt': createdAt as String,
        }
        in tarefaMaps) {
      tarefaList.add(Tarefa(title, datatarefa, horatarefa, createdAt));
    }

    return tarefaList;
  }

  Future<void> insertTarefa(Tarefa tarefa) async {
    // print('Inserindo tarefa no banco de dados');

    final db = await getDataBase();


    await db.insert(
      'tasks',
      tarefa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
