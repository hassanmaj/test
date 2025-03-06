class User {
  final int? id;
  final String name;
  final String role;

  User({this.id, required this.name, required this.role});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      role: map['role'],
    );
  }
}