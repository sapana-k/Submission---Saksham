import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:saksham/screens/social%20networking/findFriends.dart';
import './usefulInfo/usefulInfo.dart';
import 'package:saksham/screens/authentication/login.dart';
import '../../constants/bottomNavigationBar.dart';
import './map/MapPage1.dart';


var name;
TextEditingController emaiController=TextEditingController();
class GetData extends StatefulWidget {
  const GetData({Key? key}) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(itemBuilder:  (context,dynamic db, index){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SizedBox(
              height: 60,
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(140),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage("images/saksham.png"),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 60,width: 180,child: Card(
                  child:
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.person),
                      ),
                      Text(
                        "${db[index]['name']}",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color:Colors.black),
                      ),
                    ],
                  ),
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 60,width: 270,child: Card(
                  child:
                  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.phone),
                        ),
                        Expanded(
                          child: Text(
                            "${db[index]['phone']}",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ),
                      ]
                  ),),
                ),)
            ],),
            Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.email),
                  ),
                  Text(
                    "${db[index]['email']}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.work),
                  ),
                  Text(
                    "${db[index]['occupation']}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Age",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                  Text(
                    "${db[index]['age']}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),


          ],

        ),
      );
    }
        , query:FirebaseFirestore.instance.collection('User').where('email',isEqualTo: "${emaiController.text}"), itemBuilderType:PaginateBuilderType.pageView);
  }
}


class ProfilePage extends StatefulWidget {

  static const String id = 'ProfilePage';
  CollectionReference ref=FirebaseFirestore.instance.collection('User');
  List? data;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int _selectedIndex = 3;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(selectedIndex: 1)

    ,
        body: GetData()


    );
  }
}