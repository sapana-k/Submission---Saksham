
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> accessibilityList = [
  'Ramp for wheelchair',
  'Accessible toilets',
  'Lifts',
  'Drinking water facility',
  'Signage',
  'Accessible corridor',
  'Accessible parking',
  'Staircase',
  'Accessible reception',
  'Accessible route with tactile'
];

class placeMapModel {
  String place_name;
  String type_of_property;
  String address;
  String email;
  int contact;
  int zip;
  String uid = "";
  GeoPoint location;
  Map<String, dynamic> accessibility_features;


  placeMapModel({
    required this.place_name,
    required this.type_of_property,
    required this.address,
    required this.contact,
    required this.location,
    required this.zip,
    required this.email,
    required this.accessibility_features, required this.uid,
  });

  Widget info() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text(place_name, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),),
            Text(type_of_property, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300, color: Colors.grey)),
            Text(address, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.grey.shade700),),
            Text(address, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.grey.shade700),),
            Text(address, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.grey.shade700),),
            Text(address, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.grey.shade700),),
            Text(address, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.grey.shade700),),
            Text(address, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.grey.shade700),),
            Text(address, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.grey.shade700),),
            Text(address, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.grey.shade700),),


          ],
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accessibility_features" : accessibility_features,
      "address" : address,
      "place_name" : place_name,
      "zip" : zip,
      "contact" : contact,
      "uid" : uid,
      "email" : email,
      "type_of_property" : type_of_property,
      "location" : location
    };
  }

  factory placeMapModel.fromJson(QueryDocumentSnapshot<Object?> map) {
    return placeMapModel(
      accessibility_features : map["accessibility_features"],
      address : map["address"],
      place_name : map["place_name"],
      type_of_property : map["type_of_property"],
      contact : map["contact"],
      uid : map["uid"],
      email : map["email"],
      zip: map["zip"],
      location: map["location"]
    );
  }
}