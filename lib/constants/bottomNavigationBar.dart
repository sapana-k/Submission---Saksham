import 'package:flutter/material.dart';
import '../screens/map/MapPage1.dart';
import '../screens/map/mapBackend.dart';
import '../screens/social networking/findFriends.dart';
import '../screens/usefulInfo/mainFile.dart';
import 'const.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;

  const MyBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  @override

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  void _onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (selectedIndex == 0) {
      Navigator.pushNamed(context, MapPage2.id);
    }
    if (selectedIndex == 1) {
      Navigator.pushNamed(context, FindFriends.id);
    }
    if (selectedIndex == 2) {
      Navigator.pushNamed(context, MainFile.id);
    }
  }

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group_add),
      label: 'Friends',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info),
      label: 'Information',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.white,
      backgroundColor: color2,
      unselectedItemColor: color1,
      items: items,
      currentIndex: selectedIndex,
      onTap: _onTabTapped,
    );
  }
}

