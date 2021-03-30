import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitThreeBounce(
          color: Colors.blueGrey.shade700,
          size: 30,
        ),
      ),
    );
  }
}
