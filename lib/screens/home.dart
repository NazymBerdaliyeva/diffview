import 'dart:io';
import 'dart:ui' as ui;
import 'package:diffview/widgets/app_bar.dart';
import 'package:diffview/widgets/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../model/touch_points.dart';
import '../my_painter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = GlobalKey();
  File _image;
  final picker = ImagePicker();
  final points = <TouchPoints>[];
  ui.Image decodedImage;
  int w, h, start, end;


  getWidthAndHeight() async {
    decodedImage = await decodeImageFromList(_image.readAsBytesSync());

    setState(() {
      w = decodedImage.width;
      h = decodedImage.height;
    });
    print(decodedImage.width);
    print(decodedImage.height);
  }

  Future<void> _save() async {
    RenderRepaintBoundary boundary =
    globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(
      byteData.buffer.asUint8List(),
      quality: 100,
    );
    _toastInfo(result.toString());
  }

  _toastInfo(String info) {
    print("RESULT IS: ");
    print(info);
  }

  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
  Color selectedColor = Colors.black;

  //GlobalKey globalKey = GlobalKey();
  final _offsets = <Offset>[];
  final _all = <List<Offset>>[];
  final _indexes = <List<int>>[];
  final _redoOffsets = <List<Offset>>[];
  final _redoIndexes = <List<int>>[];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
//        appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//        centerTitle: false,
//        actions: _image != null
//            ? <Widget>[
//          IconButton(
//              icon: Icon(
//                Icons.undo,
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
//                  : null),
//          IconButton(
//              icon: Icon(Icons.redo,
//                  color: _redoOffsets.isNotEmpty
//                      ? Colors.black
//                      : Colors.grey),
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
//                  : null),
//          IconButton(
//              icon: Icon(Icons.history,
//                  color:
//                  _offsets.isNotEmpty ? Colors.black : Colors.grey),
//              onPressed: _offsets.isNotEmpty
//                  ? () {
//                setState(() {
//                  _offsets.clear();
//                  _indexes.clear();
//                  _redoIndexes.clear();
//                });
//              }
//                  : null),
//        ]
//            : null,
//      ),
      body: _image == null
          ? UploadImage()
          : Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomAppBar(),
            GestureDetector(
              onPanDown: (details) {
                setState(() {
                  _offsets.add(details.localPosition);
                  start = _offsets.length - 1;
                });
                print('pan down size ${_offsets.length}');
              },
              onPanUpdate: (details) {
                setState(() {
                  _offsets.add(details.localPosition);
                });
                print('pan update size ${_offsets.length}');
              },
              onPanEnd: (details) {
                setState(() {
                  _offsets.add(null);
                  _all.add(_offsets);
                  end = _offsets.length - 1;
                  _indexes.add([start, end]);
                });
                print('pan end size ${_offsets.length}');
              },
              child: RepaintBoundary(
                key: globalKey,
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Image.file(
                          _image,
                          height: 290,
                          width: 414,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 19),
                      child: ClipRRect(
                        child: CustomPaint(
//                             size: Size.infinite,
                          child: Container(
                            height: 253,
                            width: 414,
//                            color: Colors.green,
                          ),
                          painter: MyPainter(
                            offsetPoints: _offsets,
                            image: decodedImage,

                            // myBackground: _image
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.color_lens),
                    onPressed: () {},
                  ),
                  IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        setState(() {
                          _save();
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}