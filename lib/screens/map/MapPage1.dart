import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saksham/constants/mediaquery.dart';
import 'package:saksham/providers/mapFunctions.dart';
import 'package:saksham/screens/map/AddData.dart';
import 'package:saksham/screens/map/locationServices.dart';
import '../../constants/bottomNavigationBar.dart';
import '../../constants/const.dart';
import '../../constants/models/placeMapModel.dart';

var accessible = false;

class MapPage2 extends StatefulWidget {
  @override
  static const String id = 'map2_screen';
  _MapPage2State createState() => _MapPage2State();
}

class _MapPage2State extends State<MapPage2> {
  //Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  TextEditingController _searchcontroller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(selectedIndex: 0),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('User_Buildings').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                bool accessible = checkIfAccessible(building);

                placeMapModel placeModel = placeMapModel.fromJson(building);

                final marker = Marker(
                    markerId: MarkerId(placeModel.place_name),
                    position: LatLng(placeModel.location.latitude,
                        placeModel.location.longitude),
                    infoWindow: InfoWindow(
                        title: accessible ? 'Accessible' : 'Not Accessible'),
                    icon: accessible
                        ? BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen)
                        : BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueViolet),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: accessibilityList.length,
                                  itemBuilder: (context, i) {
                                    if (i == 0) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                        Text(
                                          placeModel.place_name,
                                          style: TextStyle(
                                              fontSize: 28.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(placeModel.type_of_property, style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w300),),
                                        Text(placeModel.address, style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400),),
                                      ]);
                                    }
                                    return ListTile(
                                      leading: placeModel.accessibility_features[
                                      accessibilityList[i - 1]]
                                          ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                          : Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                        title: Text(accessibilityList[i - 1]),
                                        trailing: Image.network('https://firebasestorage.googleapis.com/v0/b/saksham-8f9e0.appspot.com/o/UserContributedImages%2FAccessible%20reception?alt=media&token=112973d3-191e-460a-9f6d-36c6a750e380&_gl=1*oo0cto*_ga*MjAwMDAyNzg5MS4xNjcwMzI2MzI4*_ga_CW55HF8NVT*MTY4NTgyMDMzMS4yOC4xLjE2ODU4MjE4OTUuMC4wLjA.')
                                            );
                                  }),
                            );
                          });
                    });
                _markers.add(marker);
                accessible = false;
              }
            }

            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(16.84597245937883, 74.60139705985866),
                    zoom: 12,
                  ),
                  markers: _markers,
                ),
                Positioned(
                  top: media(context).height / 14,
                  left: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                        controller: _searchcontroller,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (String value) async{
                          print(value);
                          LatLng latlng = await LocationService().getPlace(value);
                          _mapController.animateCamera(CameraUpdate.newLatLng(latlng));
                        }),
                  ),
                  // child: SearchDelegate(),
                ),
                Positioned(
                  bottom: media(context).height / 24,
                  right: 20,
                  child: FloatingActionButton(
                    elevation: 20,
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
              ],
            );
          }),
    );
  }
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }
}
