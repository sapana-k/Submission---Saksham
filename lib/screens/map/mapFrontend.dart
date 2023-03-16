import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/const.dart';

class MapPage1 extends StatefulWidget {
  const MapPage1({Key? key}) : super(key: key);
  static const String id = 'map1_screen';
  @override
  State<MapPage1> createState() => _MapPage1State();
}

class _MapPage1State extends State<MapPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FF),
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
