import 'package:flutter/material.dart';

class UploadImage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       // getImage();
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
