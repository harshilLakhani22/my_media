class GapLocationException implements Exception {
  GapLocationException(this._cause) : super();
  final String _cause;

  @override
  String toString() => _cause;
}

class NonAppropriatePathException implements Exception {
  NonAppropriatePathException(this._cause) : super();
  final String _cause;

  @override
  String toString() => _cause;
}

class IllegalFloatingActionButtonSizeException implements Exception {
  IllegalFloatingActionButtonSizeException(this._cause) : super();
  final String _cause;

  @override
  String toString() => _cause;
}
