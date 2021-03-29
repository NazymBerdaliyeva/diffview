
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';


class MyPainter extends CustomPainter {
  MyPainter({this.offsetPoints, this.image});

  List<Offset> offsetPoints;
  ui.Image image;




  @override
  void paint(Canvas canvas, Size size) {
//    Paint background = Paint()..color = Colors.green;
   // Rect rect = Rect.fromLTWH(5, 5, size.width,size.height);
   // canvas.drawRect(rect, background);

//    canvas.save();
    var scale = size.width/image.width;
    //canvas.translate(size.width/scale, image.height/2*scale);

    //canvas.scale(size.width/image.width);
   // canvas.clipRect(rect);
//    canvas.scale(200/size.width);
    Paint imageStyle = Paint()..style = PaintingStyle.fill
    ..color = Colors.green;
//    canvas.drawImageRect(image, rect, rect, background);

   // canvas.drawImage(image,  Offset.zero, imageStyle);




    final paint = Paint()
      ..color = Colors.yellow
      ..isAntiAlias = true
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;


    for (var i = 0; i < offsetPoints.length - 1; i++) {
      if (offsetPoints[i] != null && offsetPoints[i + 1] != null) {
        canvas.drawLine(offsetPoints[i], offsetPoints[i + 1], paint);
        //canvas.restore();
      } else if (offsetPoints[i] != null && offsetPoints[i + 1] == null)
        canvas.drawPoints(ui.PointMode.points, [offsetPoints[i]], paint);
    }
  }

  //Called when CustomPainter is rebuilt.
  //Returning true because we want canvas to be rebuilt to reflect new changes.
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
