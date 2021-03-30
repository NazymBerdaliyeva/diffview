import 'package:diffview/providers/paint_provider.dart';
import 'package:diffview/stores/image/image_store.dart';
import 'package:diffview/widgets/app_bar_widget.dart';
import 'package:diffview/widgets/loading_widget.dart';
import 'package:diffview/widgets/upload_image_widget.dart';
import '../services/my_painter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = GlobalKey();
  ImageStore _imageStore;

  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
  Color selectedColor = Colors.black;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _imageStore = Provider.of<ImageStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Observer(
        builder: (context) {
          return _imageStore.loading ? LoadingWidget() : _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      return !_imageStore.hasResults ? UploadImageWidget() : _paintOnImage();
    });
  }

  Widget _paintOnImage() {
    var paintProvider = Provider.of<PaintProvider>(context, listen: false);
    final imgHeight = _imageStore.height;
    final imgWidth = _imageStore.width;
    final boxHeight = imgWidth > imgHeight ? imgHeight * 0.1 : imgHeight * 0.24;
    final double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AppBarWidget(),
        GestureDetector(
          onPanDown: (details) {
            paintProvider.onPanDown(details.localPosition);
          },
          onPanUpdate: (details) {
            paintProvider.onPanUpdate(details.localPosition);
          },
          onPanEnd: (details) {
            paintProvider.onPanEnd();
          },
          child: RepaintBoundary(
            key: globalKey,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: boxHeight < 200 ? imgHeight : boxHeight,
                    width: width * 0.94,
                    child: FittedBox(
                      child: Image.file(
                        _imageStore.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    child: CustomPaint(
                      child: Container(
                        width: width * 0.94,
                        height: boxHeight < 200 ? imgHeight : boxHeight,
                      ),
                      painter: MyPainter(
                          offsetPoints:
                          Provider.of<PaintProvider>(context).getOffsets),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
         alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(right: 24),
            child: TextButton(
              child: Text('Save', style: TextStyle(fontSize: 20),),
              onPressed: () {
                _imageStore.saveImage(globalKey);
              },
            ),
          ),
        ),
      ],
    );
  }


}
