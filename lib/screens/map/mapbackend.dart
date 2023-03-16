import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import '../../constants/modifiedCards.dart';
import '../../constants/const.dart';

class MapPage2 extends StatefulWidget {
  const MapPage2({Key? key}) : super(key: key);
  static const String id = 'map2_screen';
  @override
  State<MapPage2> createState() => _MapPage2State();
}

class _MapPage2State extends State<MapPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBF7FF),
      appBar: AppBar(
        title: Text('Saksham'),
        backgroundColor: color1,
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
