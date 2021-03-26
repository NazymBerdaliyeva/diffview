import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';

import 'model/touch_points.dart';

class MyPainter extends CustomPainter {
  MyPainter({this.offsetPoints, this.image, this.imageee});

  List<Offset> offsetPoints;
  ui.Image image;
  File imageee;



  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.green;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);
 //   ui.Image imge = Image.file(imageee);
    canvas.drawImage(image,  Offset(0.0, 0.0), Paint());



    final paint = Paint()
      ..color = Colors.deepPurple
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < offsetPoints.length - 1; i++) {
      if (offsetPoints[i] != null && offsetPoints[i + 1] != null) {
        canvas.drawLine(offsetPoints[i], offsetPoints[i + 1], paint);
      } else if (offsetPoints[i] != null && offsetPoints[i + 1] == null)
        canvas.drawPoints(ui.PointMode.points, [offsetPoints[i]], paint);
    }
  }

  //Called when CustomPainter is rebuilt.
  //Returning true because we want canvas to be rebuilt to reflect new changes.
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
