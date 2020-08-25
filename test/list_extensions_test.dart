import 'package:collection/collection.dart';
import 'package:quiver/collection.dart';
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

        group('sortBy', () {
          final first = _testItem(4, 'A');
          final second = _testItem(7, 'B');
          final third = _testItem(1, 'C');
          final list = [first, second, third];

          test('Sort ascending by element id', () {
            list.sortBy((e) => e.id);
            expect(list.indexOf(first), 1);
            expect(list.indexOf(second), 2);
            expect(list.indexOf(third), 0);
          });

          test('Sort descending by element id', () {
            list.sortByDescending((e) => e.id);
            expect(list.indexOf(first), 1);
            expect(list.indexOf(second), 0);
            expect(list.indexOf(third), 2);
          });

          test('Sort ascending by element value', () {
            list.sortBy((e) => e.value);
            expect(list.indexOf(first), 0);
            expect(list.indexOf(second), 1);
            expect(list.indexOf(third), 2);
          });

          test('Sort descending by element value', () {
            list.sortByDescending((e) => e.value);
            expect(list.indexOf(first), 2);
            expect(list.indexOf(second), 1);
            expect(list.indexOf(third), 0);
          });
        });
      });
    });
  });
}

class _testItem {
  final int id;
  final String value;

  _testItem(this.id, this.value);
}
