class User {
  final String id;
  final String name;
  final int age;
  final Gender gender;

  User(
      {required this.id,
      required this.name,
      required this.age,
      required this.gender});
}

enum Gender {
  male,
  female,
  other,
}
