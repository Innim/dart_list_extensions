import 'package:test/test.dart';
import 'package:list_ext/list_ext.dart';
import 'package:tuple/tuple.dart';

void main() {
  group('Iterable', () {
    group('Common', () {
      group('Common', () {
        group('countWhere()', () {
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
        });

        group('containsA;;()', () {
          test('should return true if has all of elements', () {
            final list = [1, 2, 3, 4];

            expect(list.containsAll([1]), true);
            expect(list.containsAll([1, 3]), true);
            expect(list.containsAll([1, 2, 3, 4]), true);
          });

          test('should return true if has all of elements in any order', () {
            final list = [1, 2, 3, 4];

            expect(list.containsAll([1, 3, 2, 4]), true);
          });

          test('should return false if has none of elements', () {
            final list = [1, 2, 3, 4];

            expect(list.containsAll([-1, 5]), false);
          });

          test('should return false if has not all of elements', () {
            final list = [1, 2, 3, 4];

            expect(list.containsAll([1, 5]), false);
            expect(list.containsAll([1, 2, 3, 4, 5]), false);
          });
        });
      });

      group('Equality', () {
        group('isNullOrEmpty/isNotNullOrEmpty', () {
          test('null iterable', () {
            Iterable list;

            expect(list.isNullOrEmpty, true);
            expect(list.isNotNullOrEmpty, false);
          });

          test('empty iterable', () {
            final Iterable list = <Object>[];

            expect(list.isNullOrEmpty, true);
            expect(list.isNotNullOrEmpty, false);
          });

          test('not empty iterable', () {
            final list = [1];

            expect(list.isNullOrEmpty, false);
            expect(list.isNotNullOrEmpty, true);
          });
        });

        group('isUnorderedEquivalent()', () {
          test('unordered equivalent true if has same elements', () {
            final list = [1, 2, 3];
            final other = [2, 1, 3];

            expect(list.isUnorderedEquivalent(other), true);
          });

          test('unordered equivalent false if has different elements', () {
            final list = [1, 2, 3];
            final other = [1, 2, 4];

            expect(list.isUnorderedEquivalent(other), false);
          });

          test('unordered equivalent false if has different length', () {
            final list = [1, 2, 3];
            final other = [1, 2];

            expect(list.isUnorderedEquivalent(other), false);
          });
        });
      });

      group('Search', () {
        group('firstWhereOrNull()', () {
          test('should return first if exist', () {
            final needle = _E(intVal: 1, strVal: 'first');
            final list = [
              needle,
              _E(intVal: 2),
              _E(intVal: 1, strVal: 'second')
            ];

            expect(list.firstWhereOrNull((e) => e.intVal == 1), needle);
          });

          test('should return null if not exist', () {
            final list = [_E(intVal: 2), _E(intVal: 3)];

            expect(list.firstWhereOrNull((e) => e.intVal == 1), null);
          });
        });
      });

      group('Safe elements access', () {
        group('firstOrNull', () {
          test('should return first element if not empty', () {
            final first = _E(intVal: 1);
            final list = [first, _E(intVal: 0)];

            expect(list.firstOrNull, first);
          });

          test('should return null if empty', () {
            final list = <Object>[];

            expect(list.firstOrNull, null);
          });
        });

        group('tryElementAt()', () {
          test('returns the element if exists', () {
            final list = [1, 2, 3];

            expect(list.tryElementAt(1), 2);
          });

          for (final index in [4, -1]) {
            test('returns null if index is out of range [$index]', () {
              final list = [1, 2, 3];

              expect(list.tryElementAt(index), null);
            });
          }

          test('returns fallback value if provided when index is out of range',
              () {
            final list = [1, 2, 3];

            expect(list.tryElementAt(4, orElse: 4), 4);
          });
        });
      });
    });

    group('Transformation', () {
      group('Common', () {
        group('reduceValue()', () {
          test('should throw error if empty', () {
            final list = <_E>[];

            expect(
              () => list.reduceValue<String>(
                (val, elVal) => val + elVal,
                (e) => e.strVal,
              ),
              throwsA(const TypeMatcher<StateError>()),
            );
          });

          test('should return first element value if has only one element', () {
            final list = [_E(strVal: 'first')];

            expect(
              list.reduceValue<String>(
                (val, elVal) => val + elVal,
                (e) => e.strVal,
              ),
              'first',
            );
          });

          test('should return combined value', () {
            final list = [_E(intVal: 1), _E(intVal: 3), _E(intVal: -2)];

            expect(
              list.reduceValue<int>(
                (val, elVal) => val + elVal,
                (e) => e.intVal,
              ),
              2,
            );
          });
        });
      });

      group('Iterables', () {
        group('chunks()', () {
          test('should split into chunks', () {
            final list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

            expect(list.chunks(3), [
              [1, 2, 3],
              [4, 5, 6],
              [7, 8, 9],
              [10]
            ]);
          });
        });

        group('intersperse()', () {
          test('should return empty iterable for empty iterable', () {
            final list = <int>[];
            expect(list.intersperse(0), <int>[]);
          });

          test('should return same iterable for iterable with 1 element', () {
            final list = <int>[1];
            expect(list.intersperse(0), [1]);
          });

          test('should return correct iterable', () {
            expect([1, 2].intersperse(0), [1, 0, 2]);
            expect([1, 2, 3].intersperse(0), [1, 0, 2, 0, 3]);
          });
        });
      });

      group('String', () {
        group('joinOf()', () {
          test('should return join of object field', () {
            final list = [_E(strVal: 'first'), _E(strVal: 'second')];

            expect(list.joinOf((e) => e.strVal, ', '), 'first, second');
          });
        });
      });

      group('Map', () {
        group('toMap()', () {
          test('should return map', () {
            final list = [1, 2, 3];

            expect(
                list.toMap(
                  (e) => 'K${e}',
                  (e) => 'V${e}',
                ),
                {
                  'K1': 'V1',
                  'K2': 'V2',
                  'K3': 'V3',
                });
          });
        });
      });
    });

    group('Math', () {
      group('sumOf()', () {
        test('sum of int elements property', () {
          final list = [_E(intVal: 1), _E(intVal: 3)];

          expect(list.sumOf((e) => e.intVal), 4);
        });
      });

      group('sumOfDouble()', () {
        test('sum of double elements property', () {
          final list = [_E(doubleVal: 1.5), _E(doubleVal: 3.1)];

          expect(list.sumOfDouble((e) => e.doubleVal), 4.6);
        });
      });

      group('avgOf()', () {
        test('ceil avg of int elements property', () {
          final list = [_E(intVal: 1), _E(intVal: 3)];

          expect(list.avgOf((e) => e.intVal), 2);
        });

        test('float avg of int elements property', () {
          final list = [_E(intVal: 1), _E(intVal: 4)];

          expect(list.avgOf((e) => e.intVal), 2.5);
        });

        test('avg of int with negative', () {
          final list = [_E(intVal: 1), _E(intVal: -3)];

          expect(list.avgOf((e) => e.intVal), -1);
        });

        test('avg of empty', () {
          final list = <_E>[];

          expect(list.avgOf((e) => e.intVal), 0);
        });
      });

      group('avgOfDouble()', () {
        test('avg of double elements property', () {
          final list = [_E(doubleVal: 1.5), _E(doubleVal: 3.2)];

          expect(list.avgOfDouble((e) => e.doubleVal), 2.35);
        });

        test('avg of double with negative', () {
          final list = [_E(doubleVal: 2.1), _E(doubleVal: -1.1)];

          expect(list.avgOfDouble((e) => e.doubleVal), .5);
        });

        test('avg of double empty', () {
          final list = <_E>[];

          expect(list.avgOfDouble((e) => e.doubleVal), 0);
        });
      });

      group('maxOf()', () {
        test('max of int', () {
          final list = [_E(intVal: 1), _E(intVal: -3), _E(intVal: 10)];

          expect(list.maxOf((e) => e.intVal), 10);
        });

        test('max of negative int', () {
          final list = [_E(intVal: -1), _E(intVal: -3), _E(intVal: -10)];

          expect(list.maxOf((e) => e.intVal), -1);
        });

        test('max of int for empty', () {
          final list = <_E>[];

          expect(list.maxOf((e) => e.intVal), 0);
        });

        test('max of double', () {
          final list = [
            _E(doubleVal: 1.5),
            _E(doubleVal: 3.2),
            _E(doubleVal: 3.3)
          ];

          expect(list.maxOf((e) => e.doubleVal), 3.3);
        });

        test('max of double for empty', () {
          final list = <_E>[];

          expect(list.maxOf((e) => e.doubleVal), 0.0);
        });
      });

      group('minOf()', () {
        test('min of int', () {
          final list = [_E(intVal: 1), _E(intVal: -3), _E(intVal: 10)];

          expect(list.minOf((e) => e.intVal), -3);
        });

        test('min of int for empty', () {
          final list = <_E>[];

          expect(list.minOf((e) => e.intVal), 0);
        });

        test('min of double', () {
          final list = [
            _E(doubleVal: 1.5),
            _E(doubleVal: 3.2),
            _E(doubleVal: 3.3)
          ];

          expect(list.minOf((e) => e.doubleVal), 1.5);
        });

        test('min of double for empty', () {
          final list = <_E>[];

          expect(list.minOf((e) => e.doubleVal), 0.0);
        });
      });
    });
  });

  group('Iterable of num', () {
    group('max()', () {
      test('max of int', () {
        final list = [10, 20, 4, 0];

        expect(list.max(), 20);
      });

      test('max of int for empty', () {
        final list = <int>[];

        expect(list.max(), 0);
      });

      test('max of double', () {
        final list = [-1.2, -10.0, -4.3];

        expect(list.max(), -1.2);
      });

      test('max of double for empty', () {
        final list = <double>[];

        expect(list.max(), 0.0);
      });
    });

    group('min()', () {
      test('min of int', () {
        final list = [10, 20, 4];

        expect(list.min(), 4);
      });

      test('min of int with zero', () {
        final list = [10, 20, 0, 4];

        expect(list.min(), 0);
      });

      test('min of int for empty', () {
        final list = <int>[];

        expect(list.min(), 0);
      });

      test('min of double', () {
        final list = [-1.2, -10.0, -4.3];

        expect(list.min(), -10.0);
      });

      test('min of double for empty', () {
        final list = <double>[];

        expect(list.min(), 0.0);
      });
    });
  });

  group('Iterable of int', () {
    group('sum()', () {
      test('sum elements', () {
        final list = [1, 2, 5];

        expect(list.sum(), 8);
      });
    });

    group('avg()', () {
      final item2 = [5, 4];
      final data = <Tuple3<String, Iterable<int>, double>>[
        const Tuple3('simple', [1, 3, 5], 3),
        const Tuple3('negative', [3, -2, 5], 2),
        Tuple3('float', item2, 4.5),
        const Tuple3('empty', [], 0),
      ];

      for (final d in data) {
        test('average elements: ${d.item1}', () {
          final list = d.item2;

          expect(list.avg(), d.item3);
        });
      }
    });
  });

  group('Iterable of double', () {
    group('sum()', () {
      test('sum elements', () {
        final list = [1.5, 2.3, 5.7];

        expect(list.sum(), 9.5);
      });
    });

    group('avg()', () {
      final data = <Tuple3<String, Iterable<double>, double>>[
        const Tuple3('simple', [1.6, 2.3, 5.7], 3.2),
        const Tuple3('negative', [1.3, 2.3, -5.7], -.7),
        const Tuple3('empty', [], 0),
      ];

      for (final d in data) {
        test('average elements: ${d.item1}', () {
          final list = d.item2;

          expect(list.avg(), closeTo(d.item3, .00001));
        });
      }
    });
  });
}

class _E {
  final int intVal;
  final double doubleVal;
  final String strVal;
  final bool boolVal;

  _E({this.intVal, this.doubleVal, this.strVal, this.boolVal});

  @override
  String toString() {
    return '_E{intVal: $intVal, doubleVal: $doubleVal, strVal: $strVal, boolVal: $boolVal}';
  }
}
