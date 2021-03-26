import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

import 'model/touch_points.dart';
import 'my_painter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Paint',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

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
  img.Image _img;
  var decodedImage;
  int w, h;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null)  {
        _image = File(pickedFile.path);
        getWidthAndHeight();


      } else {
        print('No image selected.');
      }
    });

  }
  getWidthAndHeight() async {
     decodedImage = await decodeImageFromList(_image.readAsBytesSync());
    setState(() {
      w = decodedImage.width ;
      h = decodedImage.height;
    });
    print(decodedImage.width);
    print(decodedImage.height);

  }

  Future<ui.Image> loadImage(Uint8List bytes) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  convertToImg() async {
    final imagePng = img.decodeImage(_image.readAsBytesSync());
    Uint8List bytes = await _image.readAsBytes();
    ui.Image backgroundImage = await loadImage(bytes);
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);

    final ui.Image imagee = (await codec.getNextFrame()).image;

    setState(() => _img = imagePng);
  }

  Future<void> _save() async {
    RenderRepaintBoundary boundary =
    globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result =
    await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    print(result);
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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: _image != null
            ? <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.undo,
                      color: Colors.grey,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.redo, color: Colors.grey),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.history, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _offsets.clear();
                      });
                    }),
              ]
            : null,
      ),
      body: _image == null
          ? GestureDetector(
              onTap: () {
                getImage();
                print('Hello, I am tapped');
              },
              child: Container(
                color: Colors.cyan,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      size: 100,
                      color: Colors.blueGrey.shade700,
                    ),
                    Center(
                      child: Text(
                        'Tap anywhere to open a photo',
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.5,// h.toDouble() * 0.1,
                  width: width * 0.5,//w.toDouble()* 0.1,
                  child: GestureDetector(
                    onPanDown: (details) {
                      setState(() {
                        _offsets.add(details.localPosition);
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        _offsets.add(details.localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        _offsets.add(null);
                      });
                    },
                    child: RepaintBoundary(
                      key: globalKey,
                      child: Stack(
                        children: [
//                          Center(
//                            child: Image.file(
//                                _image,
//                              height: height * 0.8,
//                              width: width * 0.8,
//
//                            ),
//                          ),
                          ClipRRect(
                            child: CustomPaint(
                               size: Size.infinite,
                              painter: MyPainter(
                                offsetPoints: _offsets,
                                image: decodedImage
                               // myBackground: _image

                              ),
                            ),
                          ),
                        ],
                      ),
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
                    children: [
                      IconButton(
                        icon: Icon(Icons.color_lens),
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: Icon(Icons.layers_clear),
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
