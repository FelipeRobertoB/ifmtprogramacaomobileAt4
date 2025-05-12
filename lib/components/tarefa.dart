import 'package:flutter/material.dart';

class Tarefa extends StatefulWidget {
  final String title;
  final String datatarefa;
  final String horatarefa;
  final String createdAt;
  

  const Tarefa(
    this.title,
    this.datatarefa,
    this.horatarefa,
    this.createdAt, {
    super.key,
  });

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'datatarefa': datatarefa,
      'horatarefa': horatarefa,
      'createdAt': createdAt,
    };
  }

  @override
  State<Tarefa> createState() => _TarefaState();
}

class _TarefaState extends State<Tarefa> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(color: Colors.blue, height: 110),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.lightBlueAccent,
                  ),
                  width: 72,
                  height: 100,
                  child: Icon(Icons.check, color: Colors.white),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tarefa: ${widget.title}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Data: ${widget.datatarefa}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Hora: ${widget.horatarefa}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Criada em: ${widget.createdAt}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 52, height: 52),
        ],
      ),
    );
  }
}
