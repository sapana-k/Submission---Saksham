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

class MainFile extends StatefulWidget {
  const MainFile({Key? key}) : super(key: key);
  static const String id = 'MainFile';
  @override
  State<MainFile> createState() => _MainFileState();
}

class _MainFileState extends State<MainFile> {
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Transport.id);
                      },
                      child: RoundCards(
                          icon: Icons.emoji_transportation,
                          text: 'Transport Facilites'),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, GovSchemesPage.id);
                        },
                        child: RoundCards(
                            icon: Icons.description,
                            text: 'Gov. schemes for PWD')),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, NGOPage.id);
                          },
                          child: RoundCards(
                              icon: Icons.favorite, text: 'NGOs support'))),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, InsuranceSchemePage.id);
                        },
                        child: RoundCards(
                            icon: Icons.health_and_safety,
                            text: 'Insurance schemes for PWD')),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SocialGatheringPage.id);
                        },
                        child: RoundCards(
                            icon: Icons.group,
                            text: 'Social Gatherings for PWD')),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RTIPage.id);
                      },
                      child: RoundCards(
                          icon: Icons.contact_page,
                          text: 'Right To Information for PWD'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
