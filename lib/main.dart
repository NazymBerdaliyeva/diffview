import 'package:diffview/providers/paint_provider.dart';
import 'package:diffview/stores/image/image_store.dart';
import 'screens/home.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ImageStore>(create: (_) => ImageStore(),),
        ChangeNotifierProvider.value(
          value: PaintProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Paint',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}


