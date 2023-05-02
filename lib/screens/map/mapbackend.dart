import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saksham/constants/bottomNavigationBar.dart';
import 'package:saksham/screens/map/AddData.dart';
import 'package:saksham/screens/map/locationServices.dart';
import '../../constants/const.dart';

var accessible = false;

class MapPage1 extends StatefulWidget {
  @override
  static const String id = 'map1_screen';
  _MapPage1State createState() => _MapPage1State();
}

class _MapPage1State extends State<MapPage1> {
  final Set<Marker> _markers = {};
  //Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _mapController;
  TextEditingController _searchcontroller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saksham'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndex: 0),
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

          return Stack(children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: _searchcontroller,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              hintText: 'Where do you wanna go?'),
                          onChanged: (value) {
                            print(value);
                          }),
                    ),
                    IconButton(
                        onPressed: () {
                          LocationService().getPlace(_searchcontroller.text);
                        },
                        icon: Icon(Icons.search)),
                  ],
                ),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(16.84597245937883, 74.60139705985866),
                      zoom: 12,
                    ),
                    markers: _markers,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 320.0,
              bottom: 20.0,
              child: FloatingActionButton(
                backgroundColor: color1,
                onPressed: () {
                  Navigator.pushNamed(context, AddDataScreen.id);
                },
                child: Icon(
                  Icons.add_location_alt,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

}