import 'package:flutter/material.dart';
import 'package:myapp/components/tarefa.dart';

class TarefasInherited extends InheritedWidget {
  // ignore: use_super_parameters
  TarefasInherited({super.key, required Widget child}) : super(child: child);

  final List<Tarefa> tarefaList = [
    Tarefa('Prova de Ingles', '2025-05-05', '14:30', '05/05/2025 13:22'),
    Tarefa('Prova de Ingles', '2025-05-05', '14:30', '05/05/2025 13:22'),
    Tarefa('Prova de Ingles', '2025-05-05', '14:30', '05/05/2025 13:22'),
  ];

  void novaTarefa(String titulo, String data, String hora, String datacriacao) {
    tarefaList.add(Tarefa(titulo, data, hora, datacriacao));
  }

  static TarefasInherited of(BuildContext context) {
    final TarefasInherited? result =
        context.dependOnInheritedWidgetOfExactType<TarefasInherited>();
    assert(result != null, 'No TarefasInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TarefasInherited old) {
    return old.tarefaList.length != tarefaList.length;
  }
}
