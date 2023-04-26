import 'package:equatable/equatable.dart';

import '../../../../domain/user/model/user.dart';

class LocalUser extends Equatable {
  final String id;
  final String name;
  final int age;
  final int gender;
  String bio = "";
  String profileBio = "";
  List<String> profileInterests = [];
  String chatAvatar = "";
  String largeBody = "";
  String largeBodyBlurCutOff = "";
  String largeBackground = "";
  String gifAvatar = "";
  String job = "";
  int mainColor = 0xFFFFFFFF;
  int backgroundColor = 0xFFFFFFFF;
  bool isMe;
  late int createdAt;
  late int updatedAt;

  LocalUser({
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
    this.job = "",
    this.profileInterests = const [],
    this.mainColor = 0xFFFFFFFF,
    this.backgroundColor = 0xFFFFFFFF,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }

  Map<String, dynamic> toDbJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isMe': isMe ? 1 : 0,
      'bio': bio,
      'profileBio': profileBio,
      'chatAvatar': chatAvatar,
      'largeBody': largeBody,
      'largeBodyBlurCutOff': largeBodyBlurCutOff,
      'largeBackground': largeBackground,
      'gifAvatar': gifAvatar,
      'job': job,
      'profileInterests': profileInterests.join(","),
      'mainColor': mainColor,
      'backgroundColor': backgroundColor,
    };
  }

  User toDomainUser() => User(
        id: id,
        name: name,
        age: age,
        gender: Gender.values[gender],
        isMe: isMe,
        bio: bio,
        profileBio: profileBio,
        chatAvatar: chatAvatar,
        largeBody: largeBody,
        largeBodyBlurCutOff: largeBodyBlurCutOff,
        largeBackground: largeBackground,
        gifAvatar: gifAvatar,
        job: job,
        profileInterests: profileInterests,
        mainColor: mainColor,
        backgroundColor: backgroundColor,
      )
        ..createdAt = createdAt
        ..updatedAt = updatedAt;

  factory LocalUser.fromDomain(User user) => LocalUser(
        id: user.id,
        name: user.name,
        age: user.age,
        gender: user.gender.index,
        isMe: user.isMe,
        bio: user.bio,
        profileBio: user.profileBio,
        chatAvatar: user.chatAvatar,
        largeBody: user.largeBody,
        largeBodyBlurCutOff: user.largeBodyBlurCutOff,
        largeBackground: user.largeBackground,
        gifAvatar: user.gifAvatar,
        job: user.job,
        profileInterests: user.profileInterests,
        mainColor: user.mainColor,
        backgroundColor: user.backgroundColor,
      )
        ..createdAt = user.createdAt
        ..updatedAt = user.updatedAt;

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      isMe: json['isMe'] == 1,
      bio: json['bio'],
      profileBio: json['profileBio'],
      chatAvatar: json['chatAvatar'],
      largeBody: json['largeBody'],
      largeBodyBlurCutOff: json['largeBodyBlurCutOff'],
      largeBackground: json['largeBackground'],
      gifAvatar: json['gifAvatar'],
      job: json['job'],
      profileInterests: (json['profileInterests'] as String).split(","),
      mainColor: json['mainColor'],
      backgroundColor: json['backgroundColor'],
    )
      ..createdAt = json['createdAt'] ?? DateTime.now().microsecondsSinceEpoch
      ..updatedAt = json['updatedAt'] ?? DateTime.now().microsecondsSinceEpoch;
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
