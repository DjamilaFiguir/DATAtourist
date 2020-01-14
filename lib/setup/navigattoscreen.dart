import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:integration_firbase/Page/ProfilePage.dart';
import 'package:integration_firbase/Page/grid_view.dart';


class Navigattoscreen extends StatefulWidget {
  Navigattoscreen({Key key, this.title, @required this.user}) : super(key: key);
  final String title;
  final FirebaseUser user;

  @override
  NavigattoscreenState createState() => NavigattoscreenState();
}

class NavigattoscreenState extends State<Navigattoscreen> {
  static FirebaseUser userMe;
  var accomoType;

  int _selectedPage = 3;
  var _pageOptions = [];
  @override
  void initState() {
    super.initState();
   
    userMe = widget.user;
    _pageOptions = [
     //ExampleScreen(),
     // Text("Home"),
      MyGridView(user: userMe), 
     // Mylocation(),
      Text("favi"),
      ProfilePage(user: userMe),
    ];
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        fixedColor: Colors.white,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color.fromARGB(255, 30, 110, 160)),
              title: Text('home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted,
                  color: Color.fromARGB(255, 30, 110, 160)),
              title: Text('search')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border,
                  color: Color.fromARGB(255, 30, 110, 160)),
              title: Text('Favorite')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,
                  color: Color.fromARGB(255, 30, 110, 160)),
              title: Text('Rated item')),
        ],
      ),
      body: _pageOptions[_selectedPage],
    );
  }
}
