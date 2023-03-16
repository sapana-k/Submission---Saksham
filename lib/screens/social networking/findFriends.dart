import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saksham/constants/userCard.dart';
//import '../../constants/modifiedCards.dart';
import '../../constants/const.dart';
import '../map/mapFrontend.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({Key? key}) : super(key: key);
  static const String id = 'findfriends_screen';
  @override
  State<FindFriends> createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  late final String gender;
  late final String name;
  late final int age;
  late final String occupation;

  @override
  final _firestore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor1,
      appBar: AppBar(
        title: Text('Find Friends'),
        backgroundColor: color1,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StreamBuilder(
                  stream: _firestore.collection('User').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    final allUsers = snapshot.data?.docs;
                    if (allUsers != null) {
                      List<UserCard> jobs = [];
                      for (var j in allUsers) {
                        jobs.add(UserCard(
                          name: j['name'],
                          gender: j['gender'],
                          age: j['age'],
                          occupation: j['occupation'],
                        ));
                      }
                      return Column(
                        children: jobs,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: color1,
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
