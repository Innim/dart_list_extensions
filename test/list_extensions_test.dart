import 'package:test/test.dart';
import 'package:list_ext/list_ext.dart';

void main() {
  group('List', () {
    group('Common', () {
      group('Get', () {
        group('random', () {
          test('should throw StateError if empty', () {
            final list = [];

            expect(
              () => list.random,
              throwsA(TypeMatcher<StateError>()),
            );
          });

          test('should return element', () {
            final list = [1, 2, 3];

            expect(
              list.random,
              anyOf(1, 2, 3),
            );
          });
        });
      });
    });

    group('Transformation', () {
      group('List', () {
        group('copyWith()', () {
          test('copy list with add element', () {
            final list = [1, 2, 3];

            expect(list.copyWith(5), [1, 2, 3, 5]);
          });

          test('copy null list with add element', () {
            List<int> list;

            expect(list.copyWith(5), [5]);
          });
        });

        group('copyWithAll()', () {
          test('copy list with add elements', () {
            final list = [1, 2, 3];

            expect(list.copyWithAll([5, 6]), [1, 2, 3, 5, 6]);
          });

          test('copy null list with add elemens', () {
            List<int> list;
            final add = [5, 6];

            final res = list.copyWithAll(add);
            expect(res, [5, 6]);
            expect(res == add, false);
          });
        });
      });
    });

    group('Modification', () {
      group('Element', () {
        group('replace', () {
          test('should replace element and return true', () {
            final list = [1, 2, 3];

            final res = list.replace(2, 5);
            expect(list, [1, 5, 3]);
            expect(res, true);
          });

          test('should replace all elements and return true', () {
            final list = [1, 2, 3, 1, 4];

            final res = list.replace(1, 6);
            expect(list, [6, 2, 3, 6, 4]);
            expect(res, true);
          });

          test('should return false if no element', () {
            final list = [1, 2, 3, 1, 4];

            final res = list.replace(5, 6);
            expect(list, [1, 2, 3, 1, 4]);
            expect(res, false);
          });
        });
      });
      group('Sorting', () {
        group('sortBy', () {
          test('Sort ascending by element id', () {
            final first = _TestItem(4, 'A');
            final second = _TestItem(7, 'B');
            final third = _TestItem(1, 'C');
            final list = [first, second, third];
            list.sortBy((e) => e.id);
            expect(list.indexOf(first), 1);
            expect(list.indexOf(second), 2);
            expect(list.indexOf(third), 0);
          });

          test('Sort ascending by element value', () {
            final first = _TestItem(10, 'F');
            final second = _TestItem(15, 'E');
            final third = _TestItem(8, 'D');
            final list = [first, second, third];
            list.sortBy((e) => e.value);
            expect(list.indexOf(first), 2);
            expect(list.indexOf(second), 1);
            expect(list.indexOf(third), 0);
          });
        });
      });

      group('sortByDescending', () {
        test('Sort descending by element id', () {
          final first = _TestItem(20, 'G');
          final second = _TestItem(30, 'H');
          final third = _TestItem(10, 'I');
          final list = [first, second, third];
          list.sortByDescending((e) => e.id);
          expect(list.indexOf(first), 1);
          expect(list.indexOf(second), 0);
          expect(list.indexOf(third), 2);
        });

        test('Sort descending by element value', () {
          final first = _TestItem(70, 'J');
          final second = _TestItem(88, 'K');
          final third = _TestItem(36, 'L');
          final list = [first, second, third];
          list.sortByDescending((e) => e.value);
          expect(list.indexOf(first), 2);
          expect(list.indexOf(second), 1);
          expect(list.indexOf(third), 0);
        });
      });
    });
  });
}

class _TestItem {
  final int id;
  final String value;

  _TestItem(this.id, this.value);
}
