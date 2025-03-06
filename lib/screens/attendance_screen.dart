import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import '../models/attendance.dart';
import '../database_helper.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Map<int, bool> _attendance = {};

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final students = studentProvider.students;

    // التحقق من وجود طلاب
    if (students.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('تسجيل الحضور')),
        body: Center(child: Text('لا يوجد طلاب متاحين')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الحضور')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          final studentId = student.id;
          if (studentId == null) {
            return ListTile(
              title: Text(student.name),
              subtitle: Text('معرف الطالب غير متاح'),
            );
          }
          return CheckboxListTile(
            title: Text(student.name),
            value: _attendance[studentId] ?? false,
            onChanged: (value) {
              setState(() {
                _attendance[studentId] = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dbHelper = DatabaseHelper();
          final date = DateTime.now();
          for (var entry in _attendance.entries) {
            final attendance = Attendance(
              studentId: entry.key, // هنا القيمة مؤكدة أنها ليست null
              date: date,
              isPresent: entry.value,
            );
            await dbHelper.addAttendance(attendance);
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تسجيل الحضور')));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}