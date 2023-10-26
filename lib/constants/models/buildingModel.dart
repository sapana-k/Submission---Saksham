import 'package:cloud_firestore/cloud_firestore.dart';

List<String> accessibility = [
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

class BuildingModel {
   Map<String, bool> accessibility_features;
   String address;
   String email;
   GeoPoint location;
   String place_name;
   String type_of_property;
   String uid;
   int zip;
   int contact;
   //List<String> imageUrl = [];

   BuildingModel({
   required this.accessibility_features,
   required this.address,
   required this.email,
   required this.location,
   required this.place_name,
   required this.type_of_property,
   required this.uid,
   required this.zip,
   required this.contact,
  //required this.imageUrl,
   });

  Map<String, dynamic> toJson() {
    return {
    "accessibility_features" : accessibility_features,
    "address" : address,
    "email"  : email,
    "location" : location,
    "place_name" : place_name,
    "type_of_property" : type_of_property,
    "zip" : zip,
    "contact" : contact,
     "uid" : uid,
   //   "imageUrl" : imageUrl
    };
  }

  factory BuildingModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return BuildingModel(
      accessibility_features : map["accessibility_features"],
      address : map["address"],
      email : map["email"],
      location : map["location"],
      place_name : map["place_name"],
      type_of_property : map["type_of_property"],
      zip : map["zip"],
      contact : map["contact"],
      uid : map["uid"],
     //   imageUrl: map["imageUrl"]
    );
  }
}