class IntersperseIterable<E> extends Iterable<E> {
  final Iterable<E> _iterable;
  final E _element;

  IntersperseIterable(this._iterable, this._element);

  @override
  Iterator<E> get iterator => IntersperseIterator<E>(
      _iterable.iterator, _element, 2 * _iterable.length - 1);
}

class IntersperseIterator<E> extends Iterator<E> {
  final Iterator<E> _iterator;
  final E _element;
  final int _length;

  int _index = 0;
  bool _even = true;

  IntersperseIterator(this._iterator, this._element, this._length);

  @override
  bool moveNext() {
    if (_length <= _index) return false;

    _even = _index % 2 == 0;
    _index++;
    return !_even || _iterator.moveNext();
  }

  @override
  E get current => _even ? _iterator.current : _element;
}
