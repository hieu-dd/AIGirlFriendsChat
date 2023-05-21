import 'package:ai_girl_friends/di/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/user/model/user.dart';

class GirlFriendsNotifier extends ChangeNotifier {
  List<User> _girlFriends = [];

  List<User> get girlFriends => _girlFriends;

  GirlFriendsNotifier() {}

  Future<List<User>> fetchGirlFriends() async {
    _girlFriends = _users;
    notifyListeners();
    return _users;
  }
}

final girlFriendsProvider =
    ChangeNotifierProvider<GirlFriendsNotifier>((ref) => getIt());

List<User> _users = [
  User(
    id: '0',
    name: 'Trist',
    age: 22,
    gender: Gender.female,
    bio: 'Tattoo artist, beer lover',
    profileBio:
        "I'm a freelance tattoo artist who loves nothing more than creating custom designs for my clients. When I'm not inking, you can usually find me at a local brewery trying out the latest craft beers.",
    job: "Tattoo artist",
    profileInterests: const [
      "Drawing",
      "Beer tasting",
      "Biking",
      "Video games",
      "Music festivals",
    ],
    mainColor: 0xFFB12929,
    backgroundColor: 0xFF25080B,
    largeBody: 'assets/images/trist.png',
    largeBodyBlurCutOff: 'assets/images/trist_bg.png',
    largeBackground: 'assets/images/trist_large_bg.png',
  ),
  User(
    id: '1',
    name: 'Yen',
    age: 23,
    gender: Gender.female,
    bio: "Dog lover, pizza enthusiast",
    profileBio:
        "I'm a student with a passion for animals and a weakness for pizza. When I'm not studying, I volunteer at the local animal shelter and spend way too much time watching Netflix.",
    job: "Student",
    profileInterests: const [
      "Hiking",
      "Playing with dogs",
      "Reading",
      "Photography",
    ],
    mainColor: 0xFFF48FB1,
    backgroundColor: 0xFF32203A,
    largeBody: 'assets/images/yen.png',
    largeBodyBlurCutOff: 'assets/images/yen_bg.png',
    largeBackground: 'assets/images/yen_large_bg.png',
    enable: true,
  ),
  User(
    id: '3',
    name: 'Jane',
    age: 21,
    gender: Gender.female,
    bio: "Dog lover, pizza enthusiast",
    profileBio:
        "I'm a student with a passion for animals and a weakness for pizza. When I'm not studying, I volunteer at the local animal shelter and spend way too much time watching Netflix.",
    job: "Student",
    profileInterests: const [
      "Hiking",
      "Playing with dogs",
      "Reading",
      "Photography",
    ],
    mainColor: 0xFFC96C5A,
    backgroundColor: 0xFFC96C5A,
    largeBody: 'assets/images/jane.png',
    largeBodyBlurCutOff: 'assets/images/jane_bg.png',
    largeBackground: 'assets/images/jane_large_bg.png',
    enable: false,
  ),
];
