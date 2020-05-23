import 'package:collection/collection.dart';
import 'package:quiver/iterables.dart';
import 'dart:math' as math;

final _unorderedEquality = UnorderedIterableEquality();
final _getNull = () => null;

/// Extension methods for any [Iterable].
extension IterableExtensions<E> on Iterable<E> {
  // Common

  /// Returns count of elements that satisfy the predicate [test].
  int countWhere(bool test(E element)) =>
      this.fold(0, (count, e) => test(e) ? count + 1 : count);

  // Common - Equality

  /// Returns the element at the [index] if exists
  /// or [orElse] if it is out of range.
  E tryElementAt(int index, {E orElse}) {
    try {
      return this.elementAt(index);
    } catch (e) {
      return orElse;
    }
  }

  /// Returns `true` if iterable is `null` or empty.
  bool get isNullOrEmpty {
    return this == null || this.isEmpty;
  }

  /// Returns `true` if iterable is not `null` and not empty.
  bool get isNotNullOrEmpty {
    return this != null && this.isNotEmpty;
  }

  // Common - Search

  /// Return the first element that satisfies the given predicate [test]
  /// or `null` if no element satisfies.
  ///
  /// See [Iterable.firstWhere].
  E firstWhereOrNull(bool test(E element)) =>
      this.firstWhere(test, orElse: _getNull);

  // Common - Safe elements access

  /// Check equality of the elements of this and [other] iterables
  /// without considering order.
  ///
  /// Return `true` if two iterable have the same number of elements,
  /// and the elements of this iterable can be paired with the elements of
  /// the other iterable, so that each pair are equal.
  bool isUnorderedEquivalent(Iterable<E> other) =>
      _unorderedEquality.equals(this, other);

  // Transformation

  /// Reduces values of elements in a collection
  /// to a single value by iteratively combining its
  /// using the provided function.
  ///
  /// The iterable must have at least one element.
  /// If it has only one element, that element is returned.
  T reduceValue<T>(T combine(T value, T elementVal), T getVal(E element)) {
    Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) {
      throw StateError("No element");
    }

    T value = getVal(iterator.current);
    while (iterator.moveNext()) {
      value = combine(value, getVal(iterator.current));
    }

    return value;
  }

  // Transformation - Iterables

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

  // Transformation - String

  /// Get string value for each element and concatenates it with [separator].
  ///
  /// [getVal] used to get string value for element. It can be value of some
  /// field, or custom stringify function.
  String joinOf(String getVal(E element), [String separator = ""]) => this.fold(
      '', (res, e) => res != '' ? res + separator + getVal(e) : getVal(e));

  // Transformation - Map

  /// Creates a Map instance from the iterable.
  ///
  /// [getKey] used to get key for result Map.
  /// [getVal] used to get value for result Map.
  Map<TKey, TVal> toMap<TKey, TVal>(
          TKey getKey(element), TVal getVal(element)) =>
      Map.fromIterable(this, key: getKey, value: getVal);

  // Math

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

  /// Returns the average value of int values by elements.
  ///
  /// [getVal] should return value for calculate average.
  /// It can be property of element, or any another value by element.
  ///
  /// If no elements, return `0`.
  double avgOf(int getVal(E element)) {
    final count = length;
    return count > 0 ? sumOf(getVal) / count : 0;
  }

  /// Returns the average value of double values by elements.
  ///
  /// [getVal] should return value for calculate average.
  /// It can be property of element, or any another value by element.
  ///
  /// If no elements, return `0`.
  double avgOfDouble(double getVal(E element)) {
    final count = length;
    return count > 0 ? sumOfDouble(getVal) / count : 0;
  }

  /// Returns the max value of int or double values by elements.
  ///
  /// [getVal] should return value for compare.
  /// It can be property of element, or any another value by element.
  ///
  /// If no elements, return zero.
  T maxOf<T extends num>(T getVal(E element)) {
    return isEmpty ? _zero() : reduceValue(math.max, getVal);
  }

  /// Returns the min value of int or double values by elements.
  ///
  /// [getVal] should return value for compare.
  /// It can be property of element, or any another value by element.
  ///
  /// If no elements, return zero.
  T minOf<T extends num>(T getVal(E element)) {
    return isEmpty ? _zero() : reduceValue(math.min, getVal);
  }
}

/// Extension methods for [Iterable] of num.
extension NumIterableExtensions<E extends num> on Iterable<E> {
  // Math

  /// Returns max value of values.
  E max() => isEmpty ? _zero() : reduce(math.max);

  /// Returns min value of values.
  E min() => isEmpty ? _zero() : reduce(math.min);
}

/// Extension methods for [Iterable] of int.
extension IntIterableExtensions on Iterable<int> {
  // Math

  /// Returns sum of values.
  int sum() => this.fold(0, (sum, v) => sum + v);

  /// Returns the average value of values.
  ///
  /// See [IterableExtensions.avgOf].
  double avg() => this.isNotEmpty ? sum() / length : 0;
}

/// Extension methods for [Iterable] of double.
extension DoubleIterableExtensions on Iterable<double> {
  // Math

  /// Returns sum of values.
  double sum() => this.fold(0, (sum, v) => sum + v);

  /// Returns the average value of values.
  ///
  /// See [IterableExtensions.avgOfDouble].
  double avg() => this.isNotEmpty ? sum() / length : 0;
}

/// Returns zero value for num, depends on required type.abs()
///
/// It will be `0` for [int] and `0.0` for [double].
T _zero<T extends num>() => T == int ? 0 : 0.0;
