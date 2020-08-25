# list_ext

[![pub package](https://img.shields.io/pub/v/list_ext)](https://pub.dartlang.org/packages/list_ext)
![Dart CI](https://github.com/Innim/dart_list_extensions/workflows/Dart%20CI/badge.svg?branch=master)

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

#### String
* `joinOf()` - get string value for each element and concatenates it with passed separator.

#### Map
* `toMap()` - creates a Map instance from the iterable.

### Math

* `maxOf()` - returns max of values by elements.
* `minOf()` - returns min of values by elements.
* `sumOf()`/`sumOfDouble()` - returns sum of values by elements.
* `avgOf()`/`avgOfDouble()` - returns the average value of values by elements.

There are specific version of methods for Iterables of num (`int` and `double`):

* `max()`.
* `min()`.
* `sum()`.
* `avg()`.

## `List` specific methods

### Common

#### Get an element

* `random` -  returns a random element from the list.


### Transformation

#### List

* `copyWith()` - Copy current list with adding element.
* `copyWithAll()` - Copy current list with adding all elements from another list.


### Sorting

#### List

* `sortBy()` - Sorts the list in ascending order of the object's field value.
* `sortByDescending()` - Sorts the list in descending order of the object's field value.