import 'package:intl/intl.dart';

bool validTime(String day, String month, String year) {
  try {
    DateFormat('d/M/y').parseStrict('$day/$month/$year');
    return true;
  } catch (e) {
    return false;
  }
}

int? getAgeFromBirthday(String time) {
  try {
    final birthday = DateFormat('d/M/y').parseStrict(time);
    DateTime now = DateTime.now();
    int age = now.year - birthday.year;
    if (now.month < birthday.month ||
        (now.month == birthday.month && now.day < birthday.day)) {
      age--;
    }
    return age;
  } catch (e) {
    return null;
  }
}
