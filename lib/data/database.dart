import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDataBase() async {
  // print('Conectando ao Banco de daods ');

  WidgetsFlutterBinding.ensureInitialized();
  // ignore: unused_local_variable
  Future<Database> database;
  return database = openDatabase(
    join(await getDatabasesPath(), 'tarefa_database.db'),

    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tasks(title TEXT, datatarefa TEXT, horatarefa TEXT, createdAt  TEXT, id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL )',
      );
    },

    version: 1,
  );
}
