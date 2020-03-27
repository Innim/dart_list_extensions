# list_ext

[![pub package](https://img.shields.io/pub/v/list_ext)](https://pub.dartlang.org/packages/url_launcher)

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