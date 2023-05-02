import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saksham/constants/bottomNavigationBar.dart';
import '../../constants/userCard.dart';
import 'package:saksham/screens/social%20networking/chattingScreen.dart';
//import '../../constants/modifiedCards.dart';
import '../../constants/const.dart';
import '../../constants/models/userModel.dart';
import '../map/mapBackend.dart';
import '../usefulInfo/mainFile.dart';
//import '../map/mapFrontend.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({Key? key}) : super(key: key);
  static const String id = 'findfriends_screen';
  @override
  State<FindFriends> createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(selectedIndex: 1),
      backgroundColor: backgroundcolor1,
      appBar: AppBar(
        title: Text('Friends List'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User")
              .where('uid',
                  isNotEqualTo: _auth.currentUser!.uid)
              .snapshots(),
          builder: ((context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                UserModel user = UserModel.fromJson(snapshot.data!.docs[index]);
                return InkWell(
                  autofocus: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChattingScreen(uid: user.uid),
                        ));
                  },
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  ),
                );
              },
            );
          })),
    );
  }
}
