import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integration_firbase/Page/filter.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MyGridView extends StatefulWidget {
  MyGridView({Key key, this.title, @required this.user}) : super(key: key);
  final String title;
  final FirebaseUser user;

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  @override
  void initState() {
    super.initState();
  }

//essey remlir from firebase
  var myPreference;
  List<dynamic> _preferenceAll = [];
  Future<List<dynamic>> getList(BuildContext context, FirebaseUser user) async {
    _preferenceAll = [];
    myPreference = await Firestore.instance
        .collection("Preference")
        .document(user.uid)
        .get();
    if (myPreference != null) {
      if (myPreference["Accommodation"] != null) {
        for (var j = 0; j < myPreference["Accommodation"].length; j++) {
          _preferenceAll.add(myPreference["Accommodation"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Food establishment"] != null) {
        for (var j = 0; j < myPreference["Food establishment"].length; j++) {
          _preferenceAll.add(myPreference["Food establishment"][j]);
        }
      }
    }

    if (myPreference != null) {
      if (myPreference["Cultural site"] != null) {
        for (var j = 0; j < myPreference["Cultural site"].length; j++) {
          _preferenceAll.add(myPreference["Cultural site"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Natural heritage"] != null) {
        for (var j = 0; j < myPreference["Natural heritage"].length; j++) {
          _preferenceAll.add(myPreference["Natural heritage"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Festival and event"] != null) {
        for (var j = 0; j < myPreference["Festival and event"].length; j++) {
          _preferenceAll.add(myPreference["Festival and event"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Tour"] != null) {
        for (var j = 0; j < myPreference["Tour"].length; j++) {
          _preferenceAll.add(myPreference["Tour"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Transport"] != null) {
        for (var j = 0; j < myPreference["Transport"].length; j++) {
          _preferenceAll.add(myPreference["Transport"][j]);
        }
      }
    }
    return _preferenceAll;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Lists",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: Color.fromARGB(250, 5, 101, 156),
          elevation: 1.5,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: 520,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/fr2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder(
              future: getList(context, widget.user),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: Center(
                      child: CollectionScaleTransition(
                        children: <Widget>[
                          Text(
                            ".",
                            style: TextStyle(fontSize: 70, color: Colors.white),
                          ),
                          Text(
                            ".",
                            style:
                                TextStyle(fontSize: 70, color: Colors.white70),
                          ),
                          Text(
                            ".",
                            style:
                                TextStyle(fontSize: 70, color: Colors.white54),
                          ),
                          Text(
                            ".",
                            style:
                                TextStyle(fontSize: 70, color: Colors.white30),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var myImg = snapshot.data[index] + ".jpg";
                      var category = snapshot.data[index];
                      return (new Container(
                          padding: new EdgeInsets.all(5.0),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10)),
                              ), //60 20
                              color: Color.fromARGB(250, 18, 146, 210),
                              elevation: 8,
                              child: Column(children: <Widget>[
                                Hero(
                                  tag: category,
                                  child: Material(
                                    child: InkWell(
                                      onTap: () => Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new Filter(
                                                    name: category,
                                                    myImg: myImg,
                                                    user: widget.user,
                                                  ))),
                                      child: new Image.asset(
                                        "img/$myImg",
                                        fit: BoxFit.cover,
                                        width: 250,
                                        height: 120, //here you
                                      ),
                                    ),
                                  ),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                new Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 2.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                )
                              ]))));
                    },
                  );
                }
              }),
        ));
  }
}
