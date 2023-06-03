// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:saksham/screens/authentication/authWelcomePage.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// //import '../../constants/modifiedCards.dart';
// import '../../constants/const.dart';
// import '../constants/models/userModel.dart';
// import '../constants/modifiedCards.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//   static const String id = 'ProfilePage_screen';
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// FirebaseAuth _auth = FirebaseAuth.instance;
//
// class _ProfilePageState extends State<ProfilePage> {
//   String uid = _auth.currentUser!.uid;
//   late UserModel user = UserModel(name: 'name', email: 'email', gender: 'gender', occupation: 'occupation', uid: uid, age: 0);
//   bool showSpinner = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     getData();
//     super.initState();
//   }
//   void getData() async{
//     setState(() {
//       showSpinner = true;
//     });
//     DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
//         .collection("User")
//         .doc(uid)
//         .get();
//     if (snapshot.exists) {
//       Map<String, dynamic> data = snapshot.data()!;
//       UserModel user = UserModel.fromJsonn(data);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundcolor1,
//       appBar: AppBar(
//         title: Text('Saksham'),
//       ),
//       body: ModalProgressHUD(
//         inAsyncCall: showSpinner,
//         child: Center(
//           child: Container(
//             margin: EdgeInsets.fromLTRB(35.0, 18.0, 35.0, 18.0),
//             child: Column(
//               //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Icon(
//                   Icons.account_circle_sharp,
//                   color: color2,
//                   size: 140.0,
//                 ),
//                 Card(
//                     elevation: 5.0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(18.0),
//                       child: Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Text(
//                               user.name,
//                               style: kRegularTextStyle,
//                             ),
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                             Text(
//                               user.age.toString(),
//                               style: kRegularTextStyle,
//                             ),
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                             Text(
//                               user.email,
//                               style: kRegularTextStyle,
//                             ),
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                             Text(
//                               user.occupation,
//                               style: kRegularTextStyle,
//                             ),
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                           ],
//                         ),
//                       ),
//                     )),
//
//                 RoundedButton(
//                     buttonColor: color1,
//                     buttonText: 'Logout',
//                     toDo: () async {
//                       await FirebaseAuth.instance.signOut();
//                       Navigator.pushNamed(context, welcomePage.id);
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
