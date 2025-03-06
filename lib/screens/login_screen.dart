import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import '../providers/halqa_provider.dart';
import 'manager_screen.dart';
import 'teacher_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper(); // استدعاء قاعدة البيانات

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'اسم المستخدم'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'كلمة المرور'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text.trim();
                String password = _passwordController.text.trim(); 

                User? user = await dbHelper.getUserByName(username);
                
                if (user != null) {
                  if (user.role == 'manager') {
                    Navigator.pushNamed(context, '/manager');
                  } else if (user.role == 'teacher') {
                    Navigator.pushNamed(context, '/teacher');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('لا يوجد صلاحية'))
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('المستخدم غير موجود'))
                  );
                }
              },
              child: Text('تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}
