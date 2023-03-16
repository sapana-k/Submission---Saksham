import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constants/const.dart';

class MapPage1 extends StatefulWidget {
  const MapPage1({Key? key}) : super(key: key);
  static const String id = 'map1_screen';
  @override
  State<MapPage1> createState() => _MapPage1State();
}

class _MapPage1State extends State<MapPage1> {
  //late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  final LatLng _center = const LatLng(45.521563, -122.677433);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          elevation: 2,
        ),
        body: Stack(
            // _googleMap(context),
            ),
      ),
    );
  }
}

Widget _googleMap(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(16.867634, 74.570389), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          // _controller.complete(controller);
        }),
  );
}
