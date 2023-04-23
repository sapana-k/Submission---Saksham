import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saksham/screens/map/mapBackend.dart';
import '../../constants/const.dart';
import '../../constants/modifiedCards.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

List<String> accessibility = [
  'Ramp_for_wheelchair',
  'Accessible_Toilets',
  'Lifts',
  'Drinking_Water_Facility',
  'Signage',
  'Accessible_Corridor',
  'Accessible_Parking',
  'Staircase',
  'Accessible_Reception',
  'Accessible_Route_with_tactile'
];

class AddData1Screen extends StatefulWidget {
  static const String id = 'addData1';
  const AddData1Screen({Key? key}) : super(key: key);

  @override
  State<AddData1Screen> createState() => _AddData1ScreenState();
}

class _AddData1ScreenState extends State<AddData1Screen> {
  List<bool> _checked = List<bool>.filled(accessibility.length, false);
  bool accessible_corridors = false;
  late String name;
  late String address;
  late int coordinates;

  bool showSpinner = false;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add information')),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Flexible(
                  //   flex: 2,
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(24.0, 50.0, 24.0, 20.0),
                  //     child: Text(
                  //       'Add info about accessible buildings',
                  //       style: TextStyle(
                  //           color: color1,
                  //           fontSize: 30.0,
                  //           fontWeight: FontWeight.w500),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
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
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey.shade600),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              //Do something with the user input.
                              name = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Place name'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          //Do something with the user input.
                          name = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Place address'),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        onChanged: (value) {
                          //Do something with the user input.
                          name = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Place location coordinates'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
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
                  SizedBox(
                    height: 8.0,
                  ),
                  CheckboxListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Ramp for wheelchair'),
                      value: _checked[0],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[0] = value!;
                        });
                      }),
                  CheckboxListTile(
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Accessible toilets'),
                      value: _checked[1],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[1] = value!;
                        });
                      }),
                  CheckboxListTile(
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Lifts'),
                      value: _checked[2],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[2] = value!;
                        });
                      }),
                  CheckboxListTile(
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Drinking water facility'),
                      value: _checked[3],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[3] = value!;
                        });
                      }),
                  CheckboxListTile(
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Signage'),
                      value: _checked[4],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[4] = value!;
                        });
                      }),
                  CheckboxListTile(
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Accessible corridor'),
                      value: _checked[5],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[5] = value!;
                        });
                      }),
                  CheckboxListTile(
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Accessible parking'),
                      value: _checked[6],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[6] = value!;
                        });
                      }),
                  CheckboxListTile(
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Staircase'),
                      value: _checked[7],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[7] = value!;
                        });
                      }),
                  CheckboxListTile(
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Accessible reception'),
                      value: _checked[8],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[8] = value!;
                        });
                      }),
                  CheckboxListTile(
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      title: Text('Route with tactile'),
                      value: _checked[9],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[9] = value!;
                        });
                      }),
                  Flexible(
                      child: Center(
                    child: RoundedButton(
                        toDo: () async {
                          //Implement registration functionality.
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            _firestore.collection('User').add({
                              'name': name,
                            });
                            // getMessages();
                            Navigator.pushNamed(context, MapPage2.id);
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            print(e);
                          }
                          // print(email);
                          // print(password);
                          print(accessible_corridors);
                        },
                        buttonText: 'Register',
                        buttonColor: color1),
                  ))
                ]),
          ),
        ),
      ),
    );
  }
}
