import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import '../models/progress.dart';
import '../database_helper.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _surahController = TextEditingController();
  final _startAyahController = TextEditingController();
  final _endAyahController = TextEditingController();
  String _evaluation = 'ممتاز';

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final students = studentProvider.students;

    // التحقق من وجود طلاب
    if (students.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('تسجيل التقدم')),
        body: Center(child: Text('لا يوجد طلاب متاحين')),
      );
    }

    // الحصول على معرف الطالب (مع التأكد من أنه ليس null)
    final studentId = students.first.id;
    if (studentId == null) {
      return Scaffold(
        appBar: AppBar(title: Text('تسجيل التقدم')),
        body: Center(child: Text('معرف الطالب غير متاح')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('تسجيل التقدم')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _evaluation,
                items: ['ممتاز', 'جيد جدا', 'جيد', 'مقبول'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _evaluation = value!;
                  });
                },
              ),
              TextFormField(
                controller: _surahController,
                decoration: InputDecoration(labelText: 'اسم السورة'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم السورة';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startAyahController,
                decoration: InputDecoration(labelText: 'بداية الآية'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال بداية الآية';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endAyahController,
                decoration: InputDecoration(labelText: 'نهاية الآية'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال نهاية الآية';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final dbHelper = DatabaseHelper();
                    final progress = Progress(
                      studentId: studentId, // استخدام studentId المؤكد أنه ليس null
                      surah: _surahController.text,
                      startAyah: int.parse(_startAyahController.text),
                      endAyah: int.parse(_endAyahController.text),
                      evaluation: _evaluation,
                      date: DateTime.now(),
                    );
                    await dbHelper.addProgress(progress);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تسجيل التقدم')));
                  }
                },
                child: Text('حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}