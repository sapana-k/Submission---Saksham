import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saksham/screens/map/mapBackend.dart';
import '../../constants/const.dart';
import '../../constants/modifiedCards.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'AddPhotos.dart';

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

class AddDataScreen extends StatefulWidget {
  static const String id = 'addData';
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  List<bool> _checked = List<bool>.filled(accessibility.length, false);

  bool showSpinner = false;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String name = 'sapana';
  String address = 'tera ghar';
  double lat = 27.3516;
  double long = 88.3239;
  int pincode = 411410;
  String type = 'hotel';

  Widget top() {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Place details',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Provide information about this place and enlist the accessiblity features provided by them.',
                    style:
                        TextStyle(fontSize: 15.0, color: Colors.grey.shade600),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Place name'),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    type = value;
                  });
                  //print(type);
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Type of place, like restaurant, mall etc.'),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.streetAddress,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Place address'),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    pincode = int.parse(value);
                  });
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Pincode'),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Location coordinates',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(
                                signed: false, decimal: true),
                            onChanged: (value) {
                              print(value);
                              double? val = double.tryParse(value);

                              if (val == null) {
                                print("sapanaaaaaa Invalid input ");
                              } else {
                                setState(() {
                                  lat = val;
                                });
                              }
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Latitude'),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(
                                signed: false, decimal: true),
                            onChanged: (value) {
                              print(value);
                              double? val = double.tryParse(value);
                              if (val == null) {
                                print("sapanaaaaaa Invalid input ");
                              } else {
                                setState(() {
                                  long = val;
                                });
                              }
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Longitude'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Accessibilty Features',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add information')),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView.builder(
            itemCount: _checked.length + 3,
            itemBuilder: (context, i) {
              if (i == 0) {
                return top();
              }
              if (i <= _checked.length) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckboxListTile(
                    fillColor: MaterialStateProperty.all(color1),
                    checkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: color1),
                        borderRadius: BorderRadius.circular(10.0)),
                    value: _checked[i - 1],
                    onChanged: (bool? v) {
                      setState(() {
                        _checked[i - 1] = v!;
                      });
                    },
                    title: Text(accessibility[i - 1]),
                  ),
                );
              }
              if (i == _checked.length + 1) {
                return bottom();
              } else {
                return Center(
                  child: Column(
                    children: [
                      RoundedButton(
                          toDo: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              Map<String, bool> map = Map<String, bool>();
                              for (int i = 0; i < _checked.length; i++) {
                                map[accessibility[i]] = _checked[i];
                              }
                              GeoPoint location = GeoPoint(lat, long);
                              await _firestore
                                  .collection('User_Buildings')
                                  .doc(_auth.currentUser?.uid)
                                  .set({
                                'place_name': name,
                                'type_of_property': type,
                                'address': address,
                                'zip': pincode,
                                'location': location,
                                'email': _auth.currentUser?.email,
                                'uid': _auth.currentUser?.uid,
                                'accessibility_features': map
                              });

                              Navigator.pushNamed(context, MapPage2.id);
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          buttonText: 'Submit',
                          buttonColor: color2),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}

Widget bottom() {
  return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Place photos',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Add helpful photos of accessiblity features provided by the place.',
                  style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600),
                ),
                SizedBox(
                  height: 8.0,
                ),
                RawMaterialButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_a_photo_rounded,
                            color: color1,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Add photos',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, color: color1),
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {
                      AddPhotos().add();
                    })
              ],
            ),
          ),
        ),
      ]);
}
