import 'package:flutter_test/flutter_test.dart';
import 'package:list_ext/list_ext.dart';

void main() {
  group('Iterable', () {
    test('count of elements with property value', () {
      final list = [
        _E(strVal: 'OK'),
        _E(strVal: 'not OK'),
        _E(),
        _E(strVal: 'OK'),
        _E(boolVal: true)
      ];

      expect(list.countWhere((e) => e.strVal == 'OK'), 2);
    });

    test('sum of int elements property', () {
      final list = [_E(intVal: 1), _E(intVal: 3)];

      expect(list.sumOf((e) => e.intVal), 4);
    });

    test('sum of double elements property', () {
      final list = [_E(doubleVal: 1.5), _E(doubleVal: 3.1)];

      expect(list.sumOfDouble((e) => e.doubleVal), 4.6);
    });

    test('isNullOrEmpty/isNotNullOrEmpty for null iterable', () {
      Iterable list;

      expect(list.isNullOrEmpty, true);
      expect(list.isNotNullOrEmpty, false);
    });

    test('isNullOrEmpty/isNotNullOrEmpty for empty iterable', () {
      Iterable list = [];

      expect(list.isNullOrEmpty, true);
      expect(list.isNotNullOrEmpty, false);
    });

    test('isNullOrEmpty/isNotNullOrEmpty for not empty iterable', () {
      final list = [1];

      expect(list.isNullOrEmpty, false);
      expect(list.isNotNullOrEmpty, true);
    });
  });

  group('Iterable of int', () {
    test('sum elements', () {
      final list = [1, 2, 5];

      expect(list.sum(), 8);
    });
  });

  group('Iterable of double', () {
    test('sum elements', () {
      final list = [1.5, 2.3, 5.7];

      expect(list.sum(), 9.5);
    });
  });
}

class _E {
  final int intVal;
  final double doubleVal;
  final String strVal;
  final bool boolVal;

  _E({this.intVal, this.doubleVal, this.strVal, this.boolVal});
}
