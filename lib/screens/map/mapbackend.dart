import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage2 extends StatefulWidget {
  @override
  static const String id = 'map2_screen';
  _MapPage2State createState() => _MapPage2State();
}

class _MapPage2State extends State<MapPage2> {
  final Set<Marker> _markers = {};
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore.collection('Buildings').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final allbuildings = snapshot.data?.docs;
          if (allbuildings != null) {
            for (var building in allbuildings) {
              //final building = doc.data();
              final marker = Marker(
                markerId: MarkerId(building['property_name']),
                position: LatLng(building['lat'], building['long']),
                infoWindow: InfoWindow(title: building['owners_name']),
              );
              _markers.add(marker);
            }
          }

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(16.84597245937883, 74.60139705985866),
              zoom: 12,
            ),
            markers: _markers,
          );
        },
      ),
    );
  }
}
