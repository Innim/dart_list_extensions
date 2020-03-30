/// Extension methods for any [Iterable].
extension IterableExtensions<E> on Iterable<E> {
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
