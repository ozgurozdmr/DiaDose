import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static const _databaseName = 'bitirme.db';
  static const _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<bool> authenticateUser(String email, String password) async {
    final db = await database;

    final List<Map<String, dynamic>> results = await db.query(
      'patients',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return results.isNotEmpty;
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('patients', user);
  }

  Future<int> insertHastaBilgi(Map<String, dynamic> hastaBilgi) async {
    final db = await database;
    return await db.insert('patients', hastaBilgi);
  }

  Future<int> insertMeasurement(Map<String, dynamic> measurement) async {
    final db = await database;
    return await db.insert('measurements', measurement);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE patients (
        id INTEGER PRIMARY KEY,
        name TEXT,
        surname TEXT,
        email TEXT,
        password TEXT,
        other_illnesses TEXT,
        insulin_dose INTEGER,
        kilogram TEXT,
        birth_date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE measurements (
        id INTEGER PRIMARY KEY,
        patient_id INTEGER,
        blood_sugar INTEGER,
        set_dose INTEGER,
        measurement_date DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (patient_id) REFERENCES patients (id)
      )
    ''');
  }

  Future<int> updatePatientInfo(Map<String, dynamic> updatedPatientInfo) async {
    final db = await database;
    final int patientId = updatedPatientInfo['id'];
    return await db.update('patients', updatedPatientInfo, where: 'id = ?', whereArgs: [patientId]);
  }

  Future<int> updateMeasurements(String date, int bloodSugar) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'measurements',
      where: 'measurement_date LIKE ?',
      whereArgs: ['$date%'],
    );

    if (results.isNotEmpty) {
      final int measurementId = results.first['id'];
      final Map<String, dynamic> updatedMeasurement = {
        'id': measurementId,
        'blood_sugar': bloodSugar,
      };

      return await db.update('measurements', updatedMeasurement, where: 'id = ?', whereArgs: [measurementId]);
    } else {
      return 0;
    }
  }

  Future<int> updatePatientWeight(int patientId, double weight) async {
    final db = await database;
    return await db.update(
      'patients',
      {'kilogram': weight.toString()},
      where: 'id = ?',
      whereArgs: [patientId],
    );
  }

  Future<int> updatePatientInsulinDose(int patientId, int insulinDose) async {
    final db = await database;
    final Map<String, dynamic> updatedPatient = {
      'id': patientId,
      'insulin_dose': insulinDose,
    };

    return await db.update('patients', updatedPatient, where: 'id = ?', whereArgs: [patientId]);
  }

  Future<int> deleteHastaBilgi(int hastaBilgiId) async {
    final db = await database;
    return await db.delete('patients', where: 'id = ?', whereArgs: [hastaBilgiId]);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('patients');
  }

  Future<Map<String, dynamic>> getHastaBilgi(int patientId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'patients',
      where: 'id = ?',
      whereArgs: [patientId],
    );
    return results.isNotEmpty ? results.first : {};
  }

  Future<List<Map<String, dynamic>>> getHastaBilgileri() async {
    final db = await database;
    return await db.query('patients');
  }

  Future<List<Map<String, dynamic>>> getMeasurements() async {
    final db = await database;
    return await db.query('measurements');
  }
 
  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'bitirme.db');

  print('Veritabanı Yolu: $dbPath');

  runApp(MyApp());
}

}
