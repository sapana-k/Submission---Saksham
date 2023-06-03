import 'package:firebase_core/firebase_core.dart';
import 'package:saksham/constants/const.dart';
import 'package:saksham/screens/authentication/login.dart';
import 'package:saksham/screens/authentication/registration.dart';
import 'package:saksham/screens/map/AddData.dart';
import 'package:saksham/screens/map/AddData1.dart';
import 'package:saksham/screens/map/AddPhotos.dart';
import 'package:saksham/screens/map/MapPage1.dart';
import 'package:saksham/screens/profile.dart';
import 'package:saksham/screens/profile_page.dart';
import 'package:saksham/screens/social%20networking/findFriends.dart';
import 'package:saksham/screens/usefulInfo/govSchemes.dart';
import 'package:saksham/screens/usefulInfo/insuranceSchemes.dart';
import 'package:saksham/screens/usefulInfo/usefulInfo.dart';
import 'package:saksham/screens/usefulInfo/ngos.dart';
import 'package:saksham/screens/usefulInfo/RTI.dart';
import 'package:saksham/screens/usefulInfo/transportFacilities.dart';
import 'package:saksham/screens/usefulInfo/socialGatherings.dart';
import 'package:flutter/material.dart';
import 'package:saksham/screens/authentication/authWelcomePage.dart';
import 'package:saksham/screens/usefulInfo/usefulInfo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', //color1 - 34, 29, 70
      theme://CustomMaterialColor(145, 145, 225) - color2
          ThemeData(primarySwatch: CustomMaterialColor(145, 145, 225).mdColor),
      home: welcomePage(),
      routes: {
        MapPage2.id: (context) => MapPage2(),
        AddPhotos.id: (context) => AddPhotos(),
        AddData1Screen.id: (context) => AddData1Screen(),
        AddDataScreen.id: (context) => AddDataScreen(),
        usefulInfo.id: (context) => usefulInfo(),
        GovSchemesPage.id: (context) => GovSchemesPage(),
        ProfilePage.id: (context) => ProfilePage(),
        RTIPage.id: (context) => RTIPage(),
        FindFriends.id: (context) => FindFriends(),
        InsuranceSchemePage.id: (context) => InsuranceSchemePage(),
        SocialGatheringPage.id: (context) => SocialGatheringPage(),
        NGOPage.id: (context) => NGOPage(),
        Transport.id: (context) => Transport(),
        welcomePage.id: (context) => welcomePage(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
    );
  }
}
