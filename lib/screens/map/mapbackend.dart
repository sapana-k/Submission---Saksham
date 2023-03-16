import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var accessible = false;

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
      body: StreamBuilder<QuerySnapshot>(
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
              if (building['lift'] == true ||
                  building['accessible_toilet'] == true ||
                  building['accessible_corridor'] == true ||
                  building['accessible_reception'] == true ||
                  building['accessible_parking'] == true ||
                  building['drinking_water'] == true ||
                  building['ramp_wheelchair'] == true ||
                  building['route_with_tactile'] == true ||
                  building['signage'] == true ||
                  building['staircase'] == true) {
                // setState(() {
                accessible = true;
                // });
              }
              //final building = doc.data();
              final marker = Marker(
                markerId: MarkerId(building['property_name']),
                position: LatLng(building['lat'], building['long']),
                infoWindow: InfoWindow(
                    title: accessible ? 'Accessible' : 'Not Accessible'),
                icon: accessible
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)
                    : BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueViolet),
              );
              _markers.add(marker);
              accessible = false;
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
