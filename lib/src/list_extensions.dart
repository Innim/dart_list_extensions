/// Extension methods for any [List].
extension ListExtensions<E> on List<E> {
  /// Copy current list with adding [element] at the end of new list.
  ///
  /// If current list is `null` - new list with [element] will be created.
  List<E> copyWith(E element) =>
      this == null ? [element] : (List.from(this)..add(element));
}
