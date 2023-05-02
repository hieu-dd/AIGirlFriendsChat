extension StringExt on String {
  bool isBlank() {
    return trim().isEmpty;
  }

  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
