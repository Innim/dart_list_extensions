/// Extension methods for any [List].
extension ListExtensions<E> on List<E> {
  /// Copy current list with adding [element] at the end of new list.
  List<E> copyWith(E element) => List.from(this)..add(element);
}
