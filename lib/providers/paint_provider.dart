import 'package:flutter/material.dart';

class PaintProvider extends ChangeNotifier {
  final _offsets = <Offset>[];
  final _indexes = <List<int>>[];
  final _redoOffsets = <List<Offset>>[];
  int startIndex, endIndex;

  List<Offset> get getOffsets {
    return _offsets;
  }

  List<List<int>> get getIndexes {
    return _indexes;
  }

  List<List<Offset>> get getRedoOffsets {
    return _redoOffsets;
  }

  onPanDown(Offset offset) {
    this._offsets.add(offset);
    this.startIndex = _offsets.length - 1;
    notifyListeners();
  }

  onPanUpdate(Offset offset) {
    this._offsets.add(offset);
    notifyListeners();
  }

  onPanEnd() {
    this._offsets.add(null);
    this.endIndex = this._offsets.length;
    this._indexes.add([startIndex, endIndex]);
    notifyListeners();
  }

  revert() {
    this._offsets.clear();
    this._indexes.clear();
    this._redoOffsets.clear();
    notifyListeners();
  }

  undo() {
    {
      var tempList =
          getOffsets.getRange(getIndexes.last.first, getIndexes.last.last);

      this._redoOffsets.add(tempList.toList());
      this.getOffsets.removeRange(getIndexes.last.first, getIndexes.last.last);
      this._indexes.removeLast();
      notifyListeners();
    }
  }

  redo() {
    int startInd = getOffsets.length;
    this._offsets.addAll(getRedoOffsets.last);
    int endInd = getOffsets.length;

    this._indexes.add([startInd, endInd]);
    this._redoOffsets.removeLast();
    notifyListeners();
  }
}
