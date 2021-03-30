import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'image_store.g.dart';

class ImageStore = _ImageStore with _$ImageStore;

abstract class _ImageStore with Store {
  File image;
  final picker = ImagePicker();
  PickedFile pickedFile;
  ui.Image decodedImage;

  @observable
  double width = 0.0;

  @observable
  double height = 0.0;

  @observable
  ObservableFuture<PickedFile> fetchImageFuture = emptyResponse;

  static ObservableFuture<PickedFile> emptyResponse = ObservableFuture
      .value(null);

  @computed
  bool get loading => fetchImageFuture.status == FutureStatus.pending;

  @computed
  bool get hasResults =>
      fetchImageFuture != emptyResponse &&
          fetchImageFuture.status == FutureStatus.fulfilled;

  @action
  Future uploadImage() async {
    try {
      final future = picker.getImage(source: ImageSource.gallery);
      fetchImageFuture = ObservableFuture(future);
      return pickedFile = await future;
    } catch (error) {
        print(error);
    }
  }
  @action
  setImage() {
    if(pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  @action
  decodeImage() async {
    decodedImage = await decodeImageFromList(image.readAsBytesSync());
    width = decodedImage.width.toDouble();
    height = decodedImage.height.toDouble();
    print(decodedImage.width);
    print(decodedImage.height);
  }

  @action
  saveImage(GlobalKey globalKey) async{
    RenderRepaintBoundary boundary =
    globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(
      byteData.buffer.asUint8List(),
      quality: 100,
    );
    print("RESULT IS: ");
    print(result.toString());
  }
}