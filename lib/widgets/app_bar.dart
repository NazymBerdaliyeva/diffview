import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              icon: Icon(
                Icons.undo,
//                color: _indexes.isNotEmpty ? Colors.black : Colors.grey,
//              ),
//              onPressed: _indexes.isNotEmpty
//                  ? () {
//                setState(() {
////                        _all.removeLast();
//                  if (_indexes.isNotEmpty) {
//                    var templist = _offsets.getRange(
//                        _indexes.last.first, _indexes.last.last);
//                    _redoOffsets.add(templist.toList());
//                    _offsets.removeRange(
//                        _indexes.last.first, _indexes.last.last);
//                    _redoIndexes.add(_indexes.last);
//                    _indexes.removeLast();
//                  }
//                });
//              }
//                  : null
          ),
          ),
          IconButton(
              icon: Icon(Icons.redo,
//                  color: _redoOffsets.isNotEmpty
//                      ? Colors.black
//                      : Colors.grey
              ),
//              onPressed: _redoOffsets.isNotEmpty
//                  ? () {
//                setState(() {
//                  _offsets.addAll(_redoOffsets.last);
//                  _redoOffsets.removeLast();
//
//                  _indexes.add([
//                    _redoIndexes.last.first,
//                    _redoIndexes.last.last
//                  ]);
//                  _redoIndexes.removeLast();
//                });
//              }
//                  : null
          ),
          IconButton(
              icon: Icon(Icons.history,
//                  color:
//                  _offsets.isNotEmpty ? Colors.black : Colors.grey
              ),
//              onPressed: _offsets.isNotEmpty
//                  ? () {
//                setState(() {
//                  _offsets.clear();
//                  _indexes.clear();
//                  _redoIndexes.clear();
//                });
//              }
//                  : null
          ),
        ],
      ),
    );
  }
}
