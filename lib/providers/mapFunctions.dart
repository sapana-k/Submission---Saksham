// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

bool checkIfAccessible(QueryDocumentSnapshot<Object?> building){
      if (
      building['accessibility_features']['Ramp for wheelchair'] == true ||
          building['accessibility_features']['Accessible toilets'] == true ||
          building['accessibility_features']['Lifts'] == true ||
              building['accessibility_features']['Drinking water facility'] == true ||
              building['accessibility_features']['Signage'] == true ||
              building['accessibility_features']['Accessible corridor'] == true ||
              building['accessibility_features']['Accessible parking'] == true ||
              building['accessibility_features']['Staircase'] == true ||
              building['accessibility_features']['Accessible reception'] == true ||
              building['accessibility_features']['Accessible route with tactile'] == true) {
        return true;
      }
      else{return false;}
}
//
// void searchPlace(String value) async {
//   List<Location> locations = await locationFromAddress(value);
//   if (locations.isNotEmpty) {
//     Location location = locations.first;
//     LatLng latLng = LatLng(location.latitude, location.longitude);
//     _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
//     _markers.clear();
//     _markers.add(Marker(
//       markerId: MarkerId('place'),
//       position: latLng,
//       infoWindow: InfoWindow(
//         title: value,
//         snippet: 'Accessibility features: ramp, wide doors',
//       ),
//     ));
//     setState(() {});
//   }
//   _searchController.clear();
// }
//
