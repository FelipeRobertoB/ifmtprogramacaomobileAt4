import 'package:flutter/material.dart';
import 'package:myapp/UI/formulario/formulario_screen.dart';
import 'package:myapp/components/tarefa.dart';
import 'package:myapp/data/tarefa_dao.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas')),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 70.0),
        child: FutureBuilder(
          future: TarefaDao().findAll(),
          builder: (context, snapshot) {
            List<Tarefa>? itens = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
                return const Center(child: Text('Estabelecendo conexão...'));

              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());

              case ConnectionState.done:
                if (snapshot.hasData && itens != null) {
                  if (itens.isNotEmpty) {
                    return ListView.builder(
                      itemCount: itens.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Tarefa tarefa = itens[index];
                        return tarefa;
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      children: [
                        const Icon(Icons.error_outline, size: 120),
                        const Text(
                          'Nenhuma tarefa Adicionada',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading tasks: ${snapshot.error}'),
                  );
                }

                return const Center(child: Text('Nenhuma tarefa disponível.'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (contextNovo) => FormularioScreen(tarefaContext: context),
            ),
          ).then((onValue) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
