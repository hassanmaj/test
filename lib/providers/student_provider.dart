import 'package:flutter/material.dart';
import '../models/student.dart';
import '../database_helper.dart';
import 'package:provider/provider.dart';

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];

  List<Student> get students => _students;

  Future<void> loadStudents(int halqaId) async {
    final dbHelper = DatabaseHelper();
    _students = await dbHelper.getStudentsByHalqa(halqaId);
    notifyListeners();
  }

  Future<void> addStudent(Student student) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.addStudent(student);
    await loadStudents(student.halqaId);
  }
}