import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final int age;
  final Gender gender;
  bool isMe;
  late int createdAt;
  late int updatedAt;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.isMe = false,
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
      'isMe': isMe ? 1 : 0,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      gender: Gender.values[json['gender']],
      isMe: json['isMe'] == 1,
    )
      ..createdAt = json['createdAt'] ?? DateTime.now().microsecondsSinceEpoch
      ..updatedAt = json['updatedAt'] ?? DateTime.now().microsecondsSinceEpoch;
  }

  factory User.fromId(String id) => User(
        id: id,
        name: '',
        age: 0,
        gender: Gender.other,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        gender,
        isMe,
        createdAt,
        updatedAt,
      ];
}

enum Gender {
  male,
  female,
  other,
}
