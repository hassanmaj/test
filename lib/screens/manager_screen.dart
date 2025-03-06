import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/halqa_provider.dart';
import '../models/halqa.dart';

class ManagerScreen extends StatelessWidget {
  final TextEditingController _halqaNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final halqaProvider = Provider.of<HalqaProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('لوحة المدير')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // إضافة حلقة جديدة
            TextField(
              controller: _halqaNameController,
              decoration: InputDecoration(labelText: 'اسم الحلقة'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_halqaNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('يرجى إدخال اسم الحلقة')),
                  );
                  return;
                }

                final halqa = Halqa(
                  name: _halqaNameController.text,
                  teacherId: 1, // يمكن تغيير هذا ليكون معرف المعلم
                );
                await halqaProvider.addHalqa(halqa); // إضافة الحلقة
                _halqaNameController.clear(); // مسح حقل الإدخال
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تمت إضافة الحلقة')),
                );
              },
              child: Text('إضافة حلقة'),
            ),

            // عرض الحلقات
            Expanded(
              child: FutureBuilder<List<Halqa>>(
                future: halqaProvider.loadHalqas(), // تحميل الحلقات
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator()); // عرض مؤشر تحميل
                  } else if (snapshot.hasError) {
                    return Center(child: Text('حدث خطأ ما')); // عرض رسالة خطأ
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('لا يوجد حلقات')); // عرض رسالة إذا كانت القائمة فارغة
                  } else {
                    final halqas = snapshot.data!;
                    return ListView.builder(
                      itemCount: halqas.length,
                      itemBuilder: (context, index) {
                        final halqa = halqas[index];
                        return ListTile(
                          title: Text(halqa.name),
                          subtitle: Text('المعلم: ${halqa.teacherId}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}