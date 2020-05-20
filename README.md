# list_ext

[![pub package](https://img.shields.io/pub/v/list_ext)](https://pub.dartlang.org/packages/list_ext)

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
}
```

## Methods classifier

### Common

* `countWhere()` - returns count of elements that satisfy the predicate.

#### Equality
* `isNullOrEmpty`/`isNotNullOrEmpty` - check for `null` or empty.
* `isUnorderedEquivalent()` - check equality of the elements of two iterables without considering order.

#### Search
* `firstWhereOrNull()` - return the first found element or `null` if no element found.

#### Safe elements access
* `tryElementAt()` - returns the element at the index if exists or `orElse` if it is out of range.

### Transformation

#### Iterables
* `chunks()` - splits into chunks of the specified size.

#### String
* `joinOf()` - get string value for each element and concatenates it with passed separator.

#### Map
* `toMap()` - creates a Map instance from the iterable.


### Math

* `sumOf()`/`sumOfDouble()` - returns sum of values by elements.
* `avgOf()`/`avgOfDouble()` - returns the average value of values by elements.

There are specific version of methods for Iterables of num (`int` and `double`):

* `sum()`.
* `avg()`.

## `List` specific methods

### Transformation

#### List

* `copyWith()` - Copy current list with adding element.
* `copyWithAll()` - Copy current list with adding all elements from another list.