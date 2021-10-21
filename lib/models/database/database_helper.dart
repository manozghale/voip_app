// import 'dart:io';

// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final _dbName = 'voip.db';
//   static final _dbVersion = 1;

//   // making it a singleton class
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   static Database _database;
//   Future<Database> get database async {
//     if (_database != null) return _database;
//     _database = await _initiateDatabase();
//     return _database;
//   }
// }

// _initiateDatabase() async {
//   Directory directory = await getApplicationDocumentDirectory();
//   String path = join(directory.path, _dbName);
//   await openDatabase(path);
// }

// getApplicationDocumentDirectory() {}
