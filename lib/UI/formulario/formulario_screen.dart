import 'package:flutter/material.dart';
import 'package:myapp/components/tarefa.dart';
import 'package:myapp/data/tarefa_dao.dart';

// ignore: must_be_immutable
class FormularioScreen extends StatefulWidget {
  FormularioScreen({super.key, required this.tarefaContext});

  BuildContext tarefaContext;

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final TextEditingController _tarefaController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _selecionarData() async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (dataSelecionada != null) {
      setState(() {
        _dataController.text = dataSelecionada.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selecionarHora() async {
    TimeOfDay? horaSelecionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horaSelecionada != null) {
      setState(() {
        _horaController.text = horaSelecionada.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(title: Text('Adicionar nova tarefa')),
        body: Center(
          child: Container(
            width: 375,
            height: 650,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Adicione o conteúdo da tarefa';
                      }
                      return null;
                    },
                    controller: _tarefaController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'TAREFA',
                      prefixIcon: Icon(Icons.task_alt),
                      fillColor: Colors.white70,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Adicione a data da tarefa';
                      }
                      return null;
                    },
                    controller: _dataController,
                    decoration: InputDecoration(
                      labelText: 'DATA',
                      fillColor: Colors.white70,
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      _selecionarData();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Adicione o horário da tarefa';
                      }
                      return null;
                    },
                    controller: _horaController,
                    decoration: InputDecoration(
                      labelText: 'HORA',
                      fillColor: Colors.white70,
                      filled: true,
                      prefixIcon: Icon(Icons.timer),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      _selecionarHora();
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      DateTime dataCriacao = DateTime.now();
                      String dataCriacaoFormatada =
                          '${dataCriacao.day.toString().padLeft(2, '0')}/'
                          '${dataCriacao.month.toString().padLeft(2, '0')}/'
                          '${dataCriacao.year} ${dataCriacao.hour.toString().padLeft(2, '0')}:'
                          '${dataCriacao.minute.toString().padLeft(2, '0')}';

                      TarefaDao().insertTarefa(
                        Tarefa(
                          _tarefaController.text,
                          _dataController.text,
                          _horaController.text,
                          dataCriacaoFormatada,
                          
                        ),
                      );
                      Navigator.pop(context);
                      // TarefasInherited.of(widget.tarefaContext).novaTarefa(
                      //   _tarefaController.text,
                      //   _dataController.text,
                      //   _horaController.text,
                      //   dataCriacaoFormatada,
                      //  );
                      //print(TarefasInherited.of(context).tarefaList);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tarefa adicionada com sucesso!'),
                        ),
                      );
                    }
                  },
                  child: Text('Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
