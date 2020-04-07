import 'package:test/test.dart';
import 'package:list_ext/list_ext.dart';

void main() {
  group('List', () {
    test('copy list with add element', () {
      final list = [1, 2, 3];

      expect(list.copyWith(5), [1, 2, 3, 5]);
    });

    test('copy null list with add element', () {
      List<int> list;

      expect(list.copyWith(5), [5]);
    });
  });
}
