import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = 'AIzaSyDKv1u2nhfijIPCUwjQOT3s2ct0HQW_56E';

  Future<Map<String, dynamic>> getPlace(String input) async {
    var placeId;
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    placeId = await json['candidates'][0]['place_id'] as String;
    final String url1 =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response1 = await http.get(Uri.parse(url1));
    var json1 = convert.jsonDecode(response1.body);
    var results = json1['result'] as Map<String, dynamic>;
    print(results);
    return results;
  }
}
