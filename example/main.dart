import 'package:list_ext/list_ext.dart';

void main() {
  final list = [1, 2, 5, 1];
  final sum = list.sum();
  print('Sum: $sum');

  final sumSquare = list.sumOf((v) => v * v);
  print('Sum of squares: $sumSquare');

  final count = list.countWhere((v) => v == 1);
  print('Count of 1: $count');
}