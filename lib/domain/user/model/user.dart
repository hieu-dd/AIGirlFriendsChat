import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final int age;
  final Gender gender;
  String bio = "";
  String profileBio = "";
  List<String> profileInterests = [];
  String chatAvatar = "";
  String largeBody = "";
  String largeBodyBlurCutOff = "";
  String largeBackground = "";
  String profileBackground = "";
  String gifAvatar = "";
  String unlockBackground = "";
  String job = "";
  int mainColor = 0xFFFFFFFF;
  int backgroundColor = 0xFFFFFFFF;
  bool enable = true;

  bool isMe;
  late int createdAt;
  late int updatedAt;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.isMe = false,
    this.bio = "",
    this.profileBio = "",
    this.chatAvatar = "",
    this.largeBody = "",
    this.largeBodyBlurCutOff = "",
    this.largeBackground = "",
    this.gifAvatar = "",
    this.unlockBackground = "",
    this.job = "",
    this.profileInterests = const [],
    this.mainColor = 0xFFFFFFFF,
    this.backgroundColor = 0xFFFFFFFF,
    this.enable = true,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }

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
