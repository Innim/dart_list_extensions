# list_ext

[![pub package](https://img.shields.io/pub/v/list_ext)](https://pub.dartlang.org/packages/list_ext)
[![Analyze & Test](https://github.com/Innim/dart_list_extensions/actions/workflows/dart.yml/badge.svg?branch=master)](https://github.com/Innim/dart_list_extensions/actions/workflows/dart.yml)
[![innim lint](https://img.shields.io/badge/style-innim_lint-40c4ff.svg)](https://pub.dev/packages/innim_lint)

Dart extension method for Iterable and List.

## Usage

To use this plugin, add `list_ext` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

Than add `import 'package:list_ext/list_ext.dart';` to the file for use extension methods.

### Example

``` dart
import 'package:list_ext/list_ext.dart';

void main() {
  final list = [1, 2, 5];
  final sum = list.sum();
  print('Sum: $sum');
  // Output: Sum: 8
}
```

## Methods classifier

### Common

* `countWhere()` - returns count of elements that satisfy the predicate.
* `containsAll()` - returns `true` if the collection contains all elements from the given collection.

#### Equality
* `isNullOrEmpty`/`isNotNullOrEmpty` - check for `null` or empty.
* `isUnorderedEquivalent()` - check equality of the elements of two iterables without considering order.

#### Search
* `firstWhereOrNull()` - return the first found element or `null` if no element found.

#### Safe elements access
* `firstOrNull` -  returns the first element or `null` if collection is empty.
* `tryElementAt()` - returns the element at the index if exists or `orElse` if it is out of range.

### Transformation

* `reduceValue()` - reduces values of elements in a collection to a single value
by iteratively combining its using the provided function.

#### Iterables
* `chunks()` - splits into chunks of the specified size.
* `intersperse()` - adds an element between elements of the iterable.
* `mapIndex()` - creates a new iterable by passing each element and index to a callback.

#### String
* `joinOf()` - get string value for each element and concatenates it with passed separator.

#### Map
* `toMap()` - creates a Map instance from the iterable.

### Math

* `maxOf()` - returns max of values by elements.
* `minOf()` - returns min of values by elements.
* `sumOf()`/`sumOfDouble()`/`sumOfBigInt` - returns sum of values by elements.
* `avgOf()`/`avgOfDouble()` - returns the average value of values by elements.

There are specific version of methods for Iterables of num (`int` and `double`):

* `max()` (also for BigInt).
* `min()` (also for BigInt).
* `sum()`.
* `avg()`.

## `List` specific methods

### Common

#### Get an element

* `random` -  returns a random element from the list.

### Modification

#### Element

* `replace()` - Remove all element occurrences and replace its with another element.
* `replaceWhere()` - Replace all elements of list that satisfy given predicate.
* `addIfNotNull()` - Adds element to the end of this list if this element is not null.

#### Sorting

* `sortBy()` - Sorts the list in ascending order of the object's field value.
* `sortByDescending()` - Sorts the list in descending order of the object's field value.

### Transformation

#### List

* `copyWith()` - Copy current list with adding element.
* `copyWithAll()` - Copy current list with adding all elements from another list.
* `copyWithReplace()` - Copy current list, replacing all element occurrences with another element.
* `copyWithReplaceWhere()` - Copy current list, replacing elements of list
that satisfy given predicate with another element.
* `copyWithInsertAll()` - Copy current list with adding all elements at the provided position of new list.