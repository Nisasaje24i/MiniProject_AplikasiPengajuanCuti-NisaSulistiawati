import 'package:pengajuan_cuti/models/cuti_model.dart';
import 'package:pengajuan_cuti/models/user.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  static late Database _database;
  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  final String _tablePengajuan = 'pengajuan';

  Future<Database> _initializeDb() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'cuti_apk_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tablePengajuan(
            id INTEGER PRIMARY KEY,
            nama TEXT,
            jabatan TEXT,
            alasan TEXT, 
            start_date TEXT, 
            end_date TEXT,
            status TEXT,
            alasan_admin TEXT

        )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertPengajuan(PengajuanModel pengajuanModel) async {
    final Database db = await database;
    await db.insert(_tablePengajuan, pengajuanModel.toMap());
  }

  Future<List<PengajuanModel>> getPengajuan() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tablePengajuan);
    return results.map((e) => PengajuanModel.fromMap(e)).toList();
  }

  Future<PengajuanModel> getPengajuanById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tablePengajuan,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.map((e) => PengajuanModel.fromMap(e)).first;
  }

  Future<void> updatePengajuan(PengajuanModel pengajuanModel) async {
    final db = await database;
    await db.update(
      _tablePengajuan,
      pengajuanModel.toMap(),
      where: 'id = ?',
      whereArgs: [pengajuanModel.id],
    );
  }

  Future<void> deletePengajuan(int id) async {
    final db = await database;
    await db.delete(
      _tablePengajuan,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updatePengajuanStatus(
      int id, String status, String alasanAdmin) async {
    final db = await database;
    await db.update(
      _tablePengajuan,
      {'status': status, 'alasan_admin': alasanAdmin},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
