import 'dart:math';

import 'package:list_ext/list_ext.dart';

/// Extension methods for any [List].
extension ListExtensions<E> on List<E> {
  // Common

  // Common - Get

  /// Returns a random element from the list.
  ///
  /// Throws a [StateError] if `this` is empty.
  E get random {
    if (isEmpty) {
      throw StateError('No element');
    }

    final rnd = Random();
    return this[rnd.nextInt(length)];
  }

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

  // Modification

  // Modification - Element

  /// Replaces all [element] occurrences with [replacement].
  ///
  /// Returns `true` if element was replaced.
  /// If [element] is not in the list than will be no changes.
  /// If there are multiple [element] in list - all will be replaced.
  bool replace(E element, E replacement) {
    var found = false;
    final len = length;
    for (var i = 0; i < len; i++) {
      if (element == this[i]) {
        this[i] = replacement;
        found = true;
      }
    }

    return found;
  }

  /// Replaces all elements of list that satisfy [test] predicate
  /// with [replacement].
  ///
  /// Returns `true` if at least one element was replaced.
  /// If no elements that satisfy [test] predicate found than will be no changes.
  bool replaceWhere(TestPredicate<E> test, E replacement) {
    var found = false;
    final len = length;
    for (var i = 0; i < len; i++) {
      if (test(this[i])) {
        this[i] = replacement;
        found = true;
      }
    }

    return found;
  }

  // Modification - Sorting

  /// Sorts the list in ascending order of the object's field value.
  void sortBy(Comparable Function(E e) getVal) =>
      sort((a, b) => getVal(a).compareTo(getVal(b)));

  /// Sorts the list in descending order of the object's field value.
  void sortByDescending(Comparable Function(E e) getVal) =>
      sort((a, b) => getVal(b).compareTo(getVal(a)));
}
