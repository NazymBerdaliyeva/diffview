import 'package:diffview/stores/image/image_store.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageStore = Provider.of<ImageStore>(context);
    return GestureDetector(
      onTap: () {
        imageStore.uploadImage().then(
              (value) => {
                if(imageStore.pickedFile != null) {
                  imageStore.setImage(),
                  imageStore.decodeImage(),
                }
              },
            );
      },
      child: Container(
        color: Colors.brown.shade50,
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
    );
  }
}
