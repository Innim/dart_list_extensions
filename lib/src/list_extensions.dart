/// Extension methods for any [List].
extension ListExtensions<E> on List<E> {
  // Transformation

  // Transformation - List

  /// Copy current list with adding [element] at the end of new list.
  ///
  /// If current list is `null` - new list with [element] will be created.
  List<E> copyWith(E element) =>
      this == null ? [element] : (List.from(this)..add(element));

  /// Copy current list with adding all [elements] at the end of new list.
  ///
  /// If current list is `null` - copy of list [elements] will be created.
  List<E> copyWithAll(List<E> elements) =>
      this == null ? List.from(elements) : (List.from(this)..addAll(elements));
}
