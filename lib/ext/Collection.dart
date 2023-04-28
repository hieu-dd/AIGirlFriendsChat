extension IterableExt<E> on Iterable<E> {
  List<T> mapTo<T>(T Function(E e) toElement) =>
      map((e) => toElement(e)).toList();
}
