import 'package:flutter/material.dart';
import 'package:saksham/screens/map/mapBackend.dart';
import '../screens/map/MapPage1.dart';
import 'const.dart';
import 'package:recase/recase.dart';


class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
   required this.gender,
    required this.name,
   required this.occupation,
   required this.age,
  }) : super(key: key);

  final String gender;
  final String name;
  final int age;
 final String occupation;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 5.0,
      child: Container(
        child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.account_circle_rounded,
                        color: color1,
                        size: 45.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('$name'.titleCase,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.black)),
                        Text('$age, '+'$occupation'.titleCase,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Icon(
                            Icons.chat,
                            size: 32.0,
                          ),
                        //  onTap: toDo,
                    )),
                  ),
                ],
              ),
            ),
        ),
    );
  }
}
