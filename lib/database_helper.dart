import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/user.dart';
import 'models/halqa.dart';
import 'models/student.dart';
import 'models/attendance.dart';
import 'models/progress.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'quran_hifz.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        role TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE halqas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        teacherId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE students(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        halqaId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE attendance(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        studentId INTEGER,
        date TEXT,
        isPresent INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE progress(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        studentId INTEGER,
        surah TEXT,
        startAyah INTEGER,
        endAyah INTEGER,
        evaluation TEXT,
        date TEXT
      )
    ''');

    // إدراج بيانات تجريبية
    int managerId = await db.insert('users', {'name': 'القاضي', 'role': 'manager'});
    int teacherId = await db.insert('users', {'name': 'حسن ماجد', 'role': 'teacher'});
    int halqaId = await db.insert('halqas', {'name': 'أبو بكر', 'teacherId': teacherId});

    await db.insert('students', {'name': 'علي', 'halqaId': halqaId});
    await db.insert('students', {'name': 'أحمد', 'halqaId': halqaId});
    await db.insert('students', {'name': 'انهار', 'halqaId': halqaId});
  }

  Future<int> addUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<int> addHalqa(Halqa halqa) async {
    final db = await database;
    return await db.insert('halqas', halqa.toMap());
  }

  Future<List<Halqa>> getHalqas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('halqas');
    return List.generate(maps.length, (i) {
      return Halqa.fromMap(maps[i]);
    });
  }

  Future<int> addStudent(Student student) async {
    final db = await database;
    return await db.insert('students', student.toMap());
  }

  Future<List<Student>> getStudentsByHalqa(int halqaId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('students', where: 'halqaId = ?', whereArgs: [halqaId]);
    return List.generate(maps.length, (i) {
      return Student.fromMap(maps[i]);
    });
  }

  Future<int> addAttendance(Attendance attendance) async {
    final db = await database;
    return await db.insert('attendance', attendance.toMap());
  }

  Future<int> addProgress(Progress progress) async {
    final db = await database;
    return await db.insert('progress', progress.toMap());
  }

  Future<List<Progress>> getProgressByStudent(int studentId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('progress', where: 'studentId = ?', whereArgs: [studentId]);
    return List.generate(maps.length, (i) {
      return Progress.fromMap(maps[i]);
    });
  }
  Future<User?> getUserByName(String name) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'users',
    where: 'name = ?',
    whereArgs: [name],
  );
  
  if (maps.isNotEmpty) {
    return User.fromMap(maps.first);
  }
  return null;
}

}
