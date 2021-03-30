import 'dart:ui';
import 'package:flutter/material.dart';


class MyPainter extends CustomPainter {
  MyPainter({this.offsetPoints,});

  List<Offset> offsetPoints;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepOrange
      ..isAntiAlias = true
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    Paint background = Paint()..color = Colors.transparent;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(rect, background);

    for (var i = 0; i < offsetPoints.length - 1; i++) {
      if (offsetPoints[i] != null && offsetPoints[i + 1] != null) {
        canvas.drawLine(offsetPoints[i], offsetPoints[i + 1], paint);
      } else if (offsetPoints[i] != null && offsetPoints[i + 1] == null)
        canvas.drawPoints(PointMode.points, [offsetPoints[i]], paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
