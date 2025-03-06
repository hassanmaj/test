import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/teacher_screen.dart';
import 'package:provider/provider.dart';
import 'providers/student_provider.dart';
import 'providers/halqa_provider.dart';
import 'screens/login_screen.dart';
import 'screens/manager_screen.dart'; // تأكد من استيراد

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => HalqaProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مركز ملتقى شباب القعقاع',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/manager': (context) => ManagerScreen(),
        '/teacher': (context) => TeacherScreen(),
      },
    );
  }
}
