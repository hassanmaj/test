import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/rogress_history_screen.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import 'attendance_screen.dart';
import 'progress_screen.dart';


class TeacherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('لوحة المعلم')),
      body: Column(
        children: [
          ListTile(
            title: Text('تسجيل الحضور'),
            onTap: () async {
              await studentProvider.loadStudents(1); // 1 هو معرف الحلقة
              Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen()));
            },
          ),
          ListTile(
            title: Text('تسجيل التقدم'),
            onTap: () async {
              await studentProvider.loadStudents(1);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressScreen()));
            },
          ),
          ListTile(
            title: Text('عرض سجل المتابعة'),
            onTap: () async {
              await studentProvider.loadStudents(1);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressHistoryScreen()));
            },
          ),
        ],
      ),
    );
  }
}