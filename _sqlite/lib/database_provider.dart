import 'package:_sqlite/asgardian_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider extends ChangeNotifier {
  Database? _db;
  bool _isLoading = false;
  bool _isInitialized = false;
  List<AsgardianModel> _asgardians = [];

  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  List<AsgardianModel> get asgardians => _asgardians;

  // DATABASE INIT
  Future<void> init() async {
    if (_isInitialized == true) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    _db = await openDatabase(
      join(await getDatabasesPath(), 'asgardians.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE asgardians(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          surname TEXT,
          age INTEGER,
          email String)
          ''');
      },
    );

    _isInitialized = true;
    _isLoading = false;
    await loadAsgardians();
  }

  // READ
  Future<void> loadAsgardians() async {
    if (_db == null) {
      return;
    }

    final data = await _db!.query('asgardians', orderBy: 'id DESC');
    _asgardians = data.map((e) => AsgardianModel.fromMap(e)).toList();

    notifyListeners();
  }

  // CREATE
  Future<void> addAsgardian(
    String name,
    String surname,
    int age,
    String email,
  ) async {
    if (_db == null) {
      return;
    }

    await _db!.insert('asgardians', {
      'name': name,
      'surname': surname,
      'age': age,
      'email': email,
    });

    await loadAsgardians();
  }

  // UPDATE
  Future<void> updateAsgardian(
    String name,
    String surname,
    int age,
    String email,
    int id,
  ) async {
    if (_db == null) {
      return;
    }

    await _db!.update(
      'asgardians',
      {'name': name, 'surname': surname, 'age': age, 'email': email},
      where: 'id = ?',
      whereArgs: [id],
    );

    await loadAsgardians();
  }

  // DELETE
  Future<void> deleteAsgardian(int id) async {
    if (_db == null) {
      return;
    }

    await _db!.delete('asgardians', where: 'id = ?', whereArgs: [id]);

    await loadAsgardians();
  }

  // DELETE DATABASE
  Future<void> deleteMyDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'asgardians.db');

    await deleteDatabase(path);
    _db = null;
    _isInitialized = false;
    _asgardians = [];
  }
}
