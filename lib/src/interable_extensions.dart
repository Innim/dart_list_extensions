import 'package:collection/collection.dart';
import 'package:list_ext/src/interables.dart';
import 'package:quiver/iterables.dart';
import 'dart:math' as math;

final _unorderedEquality = UnorderedIterableEquality();

/// Function, that returns `true` if element is pass test.
typedef TestPredicate<E> = bool Function(E element);

/// Function, that value [T] for tha elemet.
typedef GetValue<E, T> = T Function(E element);

/// Extension methods for any [Iterable].
extension IterableExtensions<E> on Iterable<E> {
  // Common

  /// Returns count of elements that satisfy the predicate [test].
  int countWhere(TestPredicate<E> test) =>
      fold(0, (count, e) => test(e) ? count + 1 : count);

  /// Returns `true` if the collection contains all elements from the [elements].
  ///
  /// Order of elements does not matter.
  ///
  /// See [contains].
  bool containsAll(Iterable<E> elements) {
    for (final e in elements) {
      if (!contains(e)) return false;
    }

    return true;
  }

  // Common - Equality

  /// Check equality of the elements of this and [other] iterables
  /// without considering order.
  ///
  /// Return `true` if two iterable have the same number of elements,
  /// and the elements of this iterable can be paired with the elements of
  /// the other iterable, so that each pair are equal.
  bool isUnorderedEquivalent(Iterable<E> other) =>
      _unorderedEquality.equals(this, other);

  // Common - Search

  /// Return the first element that satisfies the given predicate [test]
  /// or `null` if no element satisfies.
  ///
  /// See [Iterable.firstWhere].
  E? firstWhereOrNull(TestPredicate<E> test) {
    for (final element in this) {
      if (test(element)) return element;
    }

    return null;
  }

  // Common - Safe elements access

  /// Returns the first element or `null` if `this` is empty.
  E? get firstOrNull => isEmpty ? null : first;

  /// Returns the element at the [index] if exists
  /// or [orElse] if it is out of range.
  E? tryElementAt(int index, {E? orElse}) {
    try {
      return elementAt(index);
    } catch (e) {
      return orElse;
    }
  }

  // Transformation

  /// Reduces values of elements in a collection
  /// to a single value by iteratively combining its
  /// using the provided function.
  ///
  /// The iterable must have at least one element.
  /// If it has only one element, that element is returned.
  T reduceValue<T>(
      T Function(T value, T elementVal) combine, GetValue<E, T> getVal) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      throw StateError('No element');
    }

    var value = getVal(iterator.current);
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

  /// Adds [element] between elements of the iterable.
  ///
  /// Example: if we have `[1, 2, 3]` and adds `0`, then as a result
  /// we will have `[1, 0, 2, 0, 3]`.
  ///
  /// If iterable is empty then returns empty iterable.
  ///
  /// If iterable have only one element then
  /// returns interable with only one element.
  Iterable<E> intersperse(E element) =>
      isEmpty ? [] : IntersperseIterable(this, element);

  // Transformation - String

  /// Get string value for each element and concatenates it with [separator].
  ///
  /// [getVal] used to get string value for element. It can be value of some
  /// field, or custom stringify function.
  String joinOf(GetValue<E, String> getVal, [String separator = '']) =>
      fold('', (res, e) => res != '' ? res + separator + getVal(e) : getVal(e));

  // Transformation - Map

  /// Creates a Map instance from the iterable.
  ///
  /// [getKey] used to get key for result Map.
  /// [getVal] used to get value for result Map.
  Map<TKey, TVal> toMap<TKey, TVal>(
          GetValue<dynamic, TKey> getKey, GetValue<dynamic, TVal> getVal) =>
      Map.fromIterable(this, key: getKey, value: getVal);

  // Math

  /// Returns sum of int values by elements.
  ///
  /// [getVal] should return value for sum up. It can be property of element,
  /// or any another value by element.
  int sumOf(GetValue<E, int> getVal) => fold(0, (sum, e) => sum + getVal(e));

  /// Returns sum of double values by elements.
  ///
  /// [getVal] should return value for sum up. It can be property of element,
  /// or any another value by element.
  double sumOfDouble(GetValue<E, double> getVal) =>
      fold(0, (sum, e) => sum + getVal(e));

  /// Returns the average value of int values by elements.
  ///
  /// [getVal] should return value for calculate average.
  /// It can be property of element, or any another value by element.
  ///
  /// If no elements, return `0`.
  double avgOf(GetValue<E, int> getVal) {
    final count = length;
    return count > 0 ? sumOf(getVal) / count : 0;
  }

  /// Returns the average value of double values by elements.
  ///
  /// [getVal] should return value for calculate average.
  /// It can be property of element, or any another value by element.
  ///
  /// If no elements, return `0`.
  double avgOfDouble(GetValue<E, double> getVal) {
    final count = length;
    return count > 0 ? sumOfDouble(getVal) / count : 0;
  }

  /// Returns the max value of int or double values by elements.
  ///
  /// [getVal] should return value for compare.
  /// It can be property of element, or any another value by element.
  ///
  /// If no elements, return zero.
  T maxOf<T extends num>(GetValue<E, T> getVal) {
    return isEmpty ? _zero() : reduceValue(math.max, getVal);
  }

  /// Returns the min value of int or double values by elements.
  ///
  /// [getVal] should return value for compare.
  /// It can be property of element, or any another value by element.
  ///
  /// If no elements, return zero.
  T minOf<T extends num>(GetValue<E, T> getVal) {
    return isEmpty ? _zero() : reduceValue(math.min, getVal);
  }
}

extension NullableIterableExtensions<E> on Iterable<E>? {
  // Common - Equality

  /// Returns `true` if iterable is `null` or empty.
  bool get isNullOrEmpty {
    return this?.isEmpty ?? true;
  }

  /// Returns `true` if iterable is not `null` and not empty.
  bool get isNotNullOrEmpty {
    return this?.isNotEmpty ?? false;
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
  int sum() => fold(0, (sum, v) => sum + v);

  /// Returns the average value of values.
  ///
  /// See [IterableExtensions.avgOf].
  double avg() => isNotEmpty ? sum() / length : 0;
}

/// Extension methods for [Iterable] of double.
extension DoubleIterableExtensions on Iterable<double> {
  // Math

  /// Returns sum of values.
  double sum() => fold(0, (sum, v) => sum + v);

  /// Returns the average value of values.
  ///
  /// See [IterableExtensions.avgOfDouble].
  double avg() => isNotEmpty ? sum() / length : 0;
}

/// Returns zero value for num, depends on required type.
///
/// It will be `0` for [int] and `0.0` for [double].
T _zero<T extends num>() => T == int ? 0 as T : 0.0 as T;
