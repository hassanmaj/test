import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import '../models/progress.dart';
import '../database_helper.dart';

class ProgressHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final students = studentProvider.students;

    return Scaffold(
      appBar: AppBar(title: Text('سجل المتابعة')),
      body: FutureBuilder<List<Progress>>(
        future: DatabaseHelper().getProgressByStudent(students.first.id!), // يمكن تغيير هذا ليكون الطالب المحدد
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ ما'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا يوجد بيانات'));
          } else {
            final progressList = snapshot.data!;
            return ListView.builder(
              itemCount: progressList.length,
              itemBuilder: (context, index) {
                final progress = progressList[index];
                return ListTile(
                  title: Text('السورة: ${progress.surah}'),
                  subtitle: Text('الآيات: ${progress.startAyah} - ${progress.endAyah}'),
                  trailing: Text('التقييم: ${progress.evaluation}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}