import 'package:flutter/material.dart';
import '../models/halqa.dart';
import '../database_helper.dart';

class HalqaProvider with ChangeNotifier {
  List<Halqa> _halqas = [];

  List<Halqa> get halqas => _halqas;

  Future<List<Halqa>> loadHalqas() async {
    final dbHelper = DatabaseHelper();
    _halqas = await dbHelper.getHalqas(); // تحميل الحلقات من قاعدة البيانات
    notifyListeners(); // إشعار المستمعين بالتغيير
    return _halqas; // إرجاع قائمة الحلقات
  }

  Future<void> addHalqa(Halqa halqa) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.addHalqa(halqa); // إضافة حلقة جديدة
    await loadHalqas(); // إعادة تحميل الحلقات بعد الإضافة
  }
}