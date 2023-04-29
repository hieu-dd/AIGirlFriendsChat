extension IterableExt<E> on Iterable<E> {
  List<T> mapTo<T>(T Function(E e) toElement) =>
      map((e) => toElement(e)).toList();

  E? firstOrNull(bool Function(E element) test) {
    try {
      return firstWhere((element) => test(element));
    } catch (e) {
      return null;
    }
  }
}
