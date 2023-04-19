class User {
  final String id;
  final String name;
  final int age;
  final Gender gender;
  late int createdAt;
  late int updatedAt;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender.index,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      gender: Gender.values[json['gender']],
    )
      ..createdAt = json['createdAt'] ?? DateTime.now().microsecondsSinceEpoch
      ..updatedAt = json['updatedAt'] ?? DateTime.now().microsecondsSinceEpoch;
  }
}

enum Gender {
  male,
  female,
  other,
}
