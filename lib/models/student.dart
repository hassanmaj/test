class Student {
  final int? id;
  final String name;
  final int halqaId;

  Student({this.id, required this.name, required this.halqaId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'halqaId': halqaId,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      halqaId: map['halqaId'],
    );
  }
}