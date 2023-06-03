import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saksham/constants/bottomNavigationBar.dart';
import 'package:saksham/screens/map/mapBackend.dart';
import 'package:saksham/screens/usefulInfo/RTI.dart';
import 'package:saksham/screens/usefulInfo/govSchemes.dart';
import 'package:saksham/screens/usefulInfo/ngos.dart';
import 'package:saksham/screens/usefulInfo/socialGatherings.dart';
import 'package:saksham/screens/usefulInfo/transportFacilities.dart';
import '../../constants/modifiedCards.dart';
import '../../constants/const.dart';
import '../social networking/findFriends.dart';
import 'insuranceSchemes.dart';

class usefulInfo extends StatefulWidget {
  const usefulInfo({Key? key}) : super(key: key);
  static const String id = 'usefulInfo';
  @override
  State<usefulInfo> createState() => _usefulInfoState();
}

class _usefulInfoState extends State<usefulInfo> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: MyBottomNavigationBar(selectedIndex: 2),
      backgroundColor: backgroundcolor1,
      appBar: AppBar(
        title: Text('Useful Information'),
        backgroundColor: color2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                      child: tileCard(
                        toDo: (){
                          Navigator.pushNamed(context, GovSchemesPage.id);
                        },
                              icon: Icons.emoji_transportation,
                              text: 'Transport Facilites',
                      ),
                        ),
                      Expanded(
                        child: tileCard(
                          toDo: (){
                            Navigator.pushNamed(context, GovSchemesPage.id);
                          },
                          icon: Icons.description,
                          text: 'Gov. Schemes for PWD',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                  Expanded(
                  child: tileCard(
                  toDo: (){
                Navigator.pushNamed(context, GovSchemesPage.id);
                },
                  icon: Icons.favorite,
                  text: 'NGO Support',
                ),),
                    Expanded(
                      child: tileCard(
                        toDo: (){
                          Navigator.pushNamed(context, GovSchemesPage.id);
                        },
                        icon: Icons.health_and_safety,
                        text: 'Insurance schemes for PWD',
                      ),
                    ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: tileCard(
                            toDo: () {
                              Navigator.pushNamed(context, RTIPage.id);
                            },
                            icon: Icons.group,
                            text: 'Social gatherings nearby '),
                      ),
                      Expanded(
                          child: tileCard(
                            toDo: () {
                              Navigator.pushNamed(context, RTIPage.id);
                            },
                              icon: Icons.newspaper,
                              text: 'News Section'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
