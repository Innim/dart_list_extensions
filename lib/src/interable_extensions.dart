import 'package:collection/collection.dart';
import 'package:quiver/iterables.dart';

/// Extension methods for any [Iterable].
extension IterableExtensions<E> on Iterable<E> {
  // ignore: unused_field
  static final _unorderedEquality = UnorderedIterableEquality();

  /// Returns `true` if iterable is `null` or empty.
  bool get isNullOrEmpty {
    return this == null || this.isEmpty;
  }

  /// Returns `true` if iterable is not `null` and not empty.
  bool get isNotNullOrEmpty {
    return this != null && this.isNotEmpty;
  }

  /// Returns count of elements that satisfy the predicate [test].
  int countWhere(bool test(E element)) =>
      this.fold(0, (count, e) => test(e) ? count + 1 : count);

  /// Returns sum of int values by elements.
  ///
  /// [getVal] should return value for sum up. It can be property of element,
  /// or any another value by element.
  int sumOf(int getVal(E element)) => this.fold(0, (sum, e) => sum + getVal(e));

  /// Returns sum of double values by elements.
  ///
  /// [getVal] should return value for sum up. It can be property of element,
  /// or any another value by element.
  double sumOfDouble(double getVal(E element)) =>
      this.fold(0, (sum, e) => sum + getVal(e));

  /// Get string value for each element and concatenates it with [separator].
  ///
  /// [getVal] used to get string value for element. It can be value of some
  /// field, or custom stringify function.
  String joinOf(String getVal(E element), [String separator = ""]) => this.fold(
      '', (res, e) => res != '' ? res + separator + getVal(e) : getVal(e));

  /// Splits into chunks of the specified size.
  ///
  /// Example:
  /// ```
  /// final res = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].chunks(3);
  /// ```
  /// Result:
  /// ```
  /// [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]
  /// ```
  Iterable<List<E>> chunks(int size) => partition(this, size);

  /// Creates a Map instance from the iterable.
  ///
  /// [getKey] used to get key for result Map.
  /// [getVal] used to get value for result Map.
  Map<TKey, TVal> toMap<TKey, TVal>(
          TKey getKey(element), TVal getVal(element)) =>
      Map.fromIterable(this, key: getKey, value: getVal);

  /// Check equality of the elements of this and [other] iterables
  /// without considering order.
  ///
  /// Return `true` if two iterable have the same number of elements,
  /// and the elements of this iterable can be paired with the elements of
  /// the other iterable, so that each pair are equal.
  bool isUnorderedEquivalent(Iterable<E> other) =>
      _unorderedEquality.equals(this, other);
}

/// Extension methods for [Iterable] of int.
extension IntIterableExtensions on Iterable<int> {
  /// Returns sum of values.
  int sum() => this.fold(0, (sum, v) => sum + v);
}

/// Extension methods for [Iterable] of double.
extension DoubleIterableExtensions on Iterable<double> {
  /// Returns sum of values.
  double sum() => this.fold(0, (sum, v) => sum + v);
}
