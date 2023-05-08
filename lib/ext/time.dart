import 'package:intl/intl.dart';

bool validTime(String day, String month, String year) {
  try {
    DateFormat('d/M/y').parseStrict('$day/$month/$year');
    return true;
  } catch (e) {
    return false;
  }
}
