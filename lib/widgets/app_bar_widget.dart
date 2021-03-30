import 'package:diffview/providers/paint_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paintProvider = Provider.of<PaintProvider>(context, listen: false);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.undo,
              color: paintProvider.getIndexes.isNotEmpty
                  ? Colors.black
                  : Colors.grey,
            ),
            onPressed:
                paintProvider.getIndexes.isNotEmpty ? paintProvider.undo : null,
          ),
          IconButton(
            icon: Icon(
              Icons.redo,
              color: paintProvider.getRedoOffsets.isNotEmpty
                  ? Colors.black
                  : Colors.grey,
            ),
            onPressed: paintProvider.getRedoOffsets.isNotEmpty
                ? paintProvider.redo
                : null,
          ),
          IconButton(
            icon: Icon(
              Icons.history,
              color: paintProvider.getOffsets.isNotEmpty
                  ? Colors.black
                  : Colors.grey,
            ),
            onPressed: (paintProvider.getOffsets.isNotEmpty ||
                    paintProvider.getRedoOffsets.isNotEmpty)
                ? paintProvider.revert
                : null,
          ),
        ],
      ),
    );
  }
}
