class Halqa {
  final int? id;
  final String name;
  final int teacherId;

  Halqa({this.id, required this.name, required this.teacherId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'teacherId': teacherId,
    };
  }

  factory Halqa.fromMap(Map<String, dynamic> map) {
    return Halqa(
      id: map['id'],
      name: map['name'],
      teacherId: map['teacherId'],
    );
  }

  get studentsCount => null;
}