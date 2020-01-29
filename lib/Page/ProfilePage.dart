import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:integration_firbase/setup/flutter_multiselect.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title, @required this.user}) : super(key: key);
  final String title;
  final FirebaseUser user;
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  var myPreference;
  List<dynamic> _preferenceAccomo = [];
  List<dynamic> _preferenceFood = [];
  List<dynamic> _preferenceCultural = [];
  List<dynamic> _preferenceNatural = [];
  List<dynamic> _preferenceEvent = [];
  List<dynamic> _preferenceTour = [];
  List<dynamic> _preferenceTransport = [];
  final FocusNode myFocusNode = FocusNode();
  Map<String, dynamic> preferenceType = new Map<String, dynamic>();
  List<dynamic> documents = [
    "Accommodation",
    "Food establishment",
    "Cultural site",
    "Natural heritage",
    "Festival and event",
    "Tour",
    "Transport"
  ];
  void addPreferenceType(dynamic value, String champ) async {
    preferenceType[champ] = value;
    try {
      DocumentReference currentUid = Firestore.instance
          .collection("Preference")
          .document('${widget.user.uid}');
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(currentUid, preferenceType);
      });
    } catch (e) {
      print(e.message);
    }
  }
  
 static List<dynamic> _preferenceAll = [];
  void getPreferenceType(BuildContext context, FirebaseUser user) async {
    myPreference = await Firestore.instance
        .collection("Preference")
        .document(user.uid)
        .get();

    if (myPreference != null) {
      if (myPreference["Accommodation"] != null) {
        for (var j = 0; j < myPreference["Accommodation"].length; j++) {
          _preferenceAccomo.add(myPreference["Accommodation"][j]);
          _preferenceAll.add(myPreference["Accommodation"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Food establishment"] != null) {
        for (var j = 0; j < myPreference["Food establishment"].length; j++) {
          _preferenceFood.add(myPreference["Food establishment"][j]);
           _preferenceAll.add(myPreference["Food establishment"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Cultural site"] != null) {
        for (var j = 0; j < myPreference["Cultural site"].length; j++) {
          _preferenceCultural.add(myPreference["Cultural site"][j]);
           _preferenceAll.add(myPreference["Cultural site"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Natural heritage"] != null) {
        for (var j = 0; j < myPreference["Natural heritage"].length; j++) {
          _preferenceNatural.add(myPreference["Natural heritage"][j]);
          _preferenceAll.add(myPreference["Natural heritage"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Festival and event"] != null) {
        for (var j = 0; j < myPreference["Festival and event"].length; j++) {
          _preferenceEvent.add(myPreference["Festival and event"][j]);
           _preferenceAll.add(myPreference["Festival and event"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Tour"] != null) {
        for (var j = 0; j < myPreference["Tour"].length; j++) {
          _preferenceTour.add(myPreference["Tour"][j]);
          _preferenceAll.add(myPreference["Tour"][j]);
        }
      }
    }
    if (myPreference != null) {
      if (myPreference["Transport"] != null) {
        for (var j = 0; j < myPreference["Transport"].length; j++) {
          _preferenceTransport.add(myPreference["Transport"][j]);
          _preferenceAll.add(myPreference["Transport"][j]);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPreferenceType(context, widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Profile",style: prefix0.TextStyle(fontSize: 25),),
          elevation: 1.5,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('users')
              .document(widget.user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done ||
                snapshot.hasData) {
              return checkRole(snapshot.data);
            } else {
              return new Center(
                child: CollectionScaleTransition(
                  children: <Widget>[
                    Text(
                      ".",
                      style: TextStyle(fontSize: 70, color: Color.fromARGB(250, 30, 110, 160)),
                    ),
                    Text(
                      ".",
                      style: TextStyle(fontSize: 70, color: Color.fromARGB(200, 30, 110, 160)),
                    ),
                    Text(
                      ".",
                      style: TextStyle(fontSize: 70, color: Color.fromARGB(150, 30, 110, 160)),
                    ),
                    Text(
                      ".",
                      style: TextStyle(fontSize: 70, color: Color.fromARGB(100, 30, 110, 160)),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }

  Stack checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data['role'] == 'Admin') {
      return adminPage(snapshot);
    } else {
      return userPage(snapshot);
    }
  }

  Stack adminPage(DocumentSnapshot snapshot) {
    return Stack(
      children: <Widget>[
        Container(
          child: Text(snapshot.data['role'] + ' ' + snapshot.data['Name']),
        )
      ],
    );
  }

  Stack userPage(DocumentSnapshot snapshot) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/fr2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  height: 155.0,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child:
                            new Stack(fit: StackFit.loose, children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                  width: 130.0,
                                  height: 130.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: new ExactAssetImage(
                                          'assets/images/as.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 83.0, right: 95.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20.0,
                                    child: new Icon(
                                      Icons.camera_alt,
                                      color: Color.fromARGB(255, 30, 110, 160),
                                    ),
                                  )
                                ],
                              )),
                        ]),
                      ),
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Card(
                      color: Color.fromARGB(88, 185, 215, 255),
                      elevation: 35.0,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                top: 25.0,
                              ),
                              child: Center(
                                child: new Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Welcome ' + snapshot.data['Name'],
                                          style: TextStyle(
                                            fontSize: 26.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, -3.0),
                                                blurRadius: 7.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                              Shadow(
                                                offset: Offset(0.0, -3.0),
                                                blurRadius: 12.0,
                                                color: Color.fromARGB(
                                                    255, 30, 110, 160),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Preferences and Needs',
                                        style: TextStyle(
                                            fontSize: 18.0,//here you
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status
                                          ? _getEditIcon()
                                          : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new MultiSelect(
                                      autovalidate: true,
                                      titleText: "Accommodation",

                                      enabeled: !_status,
                                      user: widget.user,
                                      initialValue: _preferenceAccomo,
                                      value: null,
                                      dataSource: [
                                        {
                                          "Type": "Children's gite",
                                          "value": "Children's gite",
                                        },
                                        {
                                          "Type": "Group lodging",
                                          "value": "Group lodging",
                                        },
                                        {
                                          "Type": "Hotel",
                                          "value": "Hotel",
                                        },
                                        {
                                          "Type": "Holiday centre",
                                          "value": "Holiday centre",
                                        },
                                        {
                                          "Type": "Club or holiday village",
                                          "value": "Club or holiday village",
                                        },
                                        {
                                          "Type": "Campsite",
                                          "value": "Campsite",
                                        },
                                        {
                                          "Type": "Camper van area",
                                          "value": "Camper van area",
                                        },
                                        {
                                          "Type": "Camping and caravanning",
                                          "value": "Camping and caravanning",
                                        },
                                        {
                                          "Type": "Collective accommodation",
                                          "value": "Collective accommodation",
                                        },
                                        {
                                          "Type": "Guesthouse",
                                          "value": "Guesthouse",
                                        },
                                        {
                                          "Type": "Self catering accommodation",
                                          "value":
                                              "Self catering accommodation",
                                        },
                                        {
                                          "Type": "Hotel restaurant",
                                          "value": "Hotel restaurant",
                                        },
                                        {
                                          "Type": "Holiday resort",
                                          "value": "Holiday resort",
                                        },
                                        {
                                          "Type": "Hotel trade",
                                          "value": "Hotel trade",
                                        }
                                      ],
                                      textField: 'Type',
                                      valueField: 'Type',
                                      filterable: true,
                                      required: false,
                                      onSaved: (value) {
                                        // val.add(value);
                                        // addPreferenceType(value, "Accommodation");
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new MultiSelect(
                                      autovalidate: true,
                                      titleText: "Food establishment",
                                      enabeled: !_status,
                                      user: widget.user,
                                      initialValue: _preferenceFood,
                                      dataSource: [
                                        {
                                          "display": "Restaurant",
                                          "value": "Restaurant",
                                        },
                                        {
                                          "display": "Fast food restaurant",
                                          "value": "Fast food restaurant",
                                        },
                                        {
                                          "display": "Mountain restaurant",
                                          "value": "Mountain restaurant",
                                        },
                                        {
                                          "display": "Ice cream shop",
                                          "value": "Ice cream shop",
                                        },
                                        {
                                          "display": "Self service cafeteria",
                                          "value": "Self service cafeteria",
                                        },
                                        {
                                          "display": "Street food",
                                          "value": "Street food",
                                        },
                                        {
                                          "display": "Bakery",
                                          "value": "Bakery",
                                        },
                                        {
                                          "display": "Boat restaurant",
                                          "value": "Boat restaurant",
                                        }
                                      ],
                                      textField: 'display',
                                      valueField: 'display',
                                      filterable: true,
                                      required: false,
                                      value: null,
                                      onSaved: (value) {
                                        // addPreferenceType( value, "Food establishment");
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new MultiSelect(
                                      autovalidate: true,
                                      titleText: "Cultural site",
                                      enabeled: !_status,
                                      user: widget.user,
                                      initialValue: _preferenceCultural,
                                      dataSource: [
                                        {
                                          "display": "Archeological site",
                                          "value": "Archeological site",
                                        },
                                        {
                                          "display": "Library",
                                          "value": "Library",
                                        },
                                        {
                                          "display": "Museum",
                                          "value": "Museum",
                                        },
                                        {
                                          "display": "Lighthouse",
                                          "value": "Lighthouse",
                                        },
                                        {
                                          "display": "Castle",
                                          "value": "Castle",
                                        },
                                        {
                                          "display": "Chapel",
                                          "value": "Chapel",
                                        },
                                        {
                                          "display": "Fountain",
                                          "value": "Fountain",
                                        },
                                        {
                                          "display": "Mosque",
                                          "value": "Mosque",
                                        },
                                        {
                                          "display": "Wash house",
                                          "value": "Wash house",
                                        },
                                        {
                                          "display": "Park and garden",
                                          "value": "Park and garden",
                                        }
                                      ],
                                      textField: 'display',
                                      valueField: 'display',
                                      filterable: true,
                                      required: false,
                                      value: null,
                                      onSaved: (value) {
                                        //addPreferenceType( value, "Cultural site");
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new MultiSelect(
                                      autovalidate: true,
                                      titleText: "Natural heritage",
                                      enabeled: !_status,
                                      user: widget.user,
                                      initialValue: _preferenceNatural,
                                      dataSource: [
                                        {
                                          "display": "Beach",
                                          "value": "Beach",
                                        },
                                        {
                                          "display": "Forest",
                                          "value": "Forest",
                                        },
                                        {
                                          "display": "Waterfall",
                                          "value": "Waterfall",
                                        },
                                        {
                                          "display": "Mountain",
                                          "value": "Mountain",
                                        },
                                        {
                                          "display": "River",
                                          "value": "River",
                                        },
                                        {
                                          "display": "Hillsides",
                                          "value": "Hillsides",
                                        },
                                        {
                                          "display": "Grassland",
                                          "value": "Grassland",
                                        },
                                        {
                                          "display": "Natural park",
                                          "value": "Natural park",
                                        }
                                      ],
                                      textField: 'display',
                                      valueField: 'display',
                                      filterable: true,
                                      required: false,
                                      value: null,
                                      onSaved: (value) {
                                        // addPreferenceType(value, "Natural heritage");
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new MultiSelect(
                                      autovalidate: true,
                                      titleText: "Festival and event",
                                      enabeled: !_status,
                                      user: widget.user,
                                      initialValue: _preferenceEvent,
                                      dataSource: [
                                        {
                                          "display": "Cultural event",
                                          "value": "Cultural event",
                                        },
                                        {
                                          "display": "Childrens' event",
                                          "value": "Childrens' event",
                                        },
                                        {
                                          "display": "Business event",
                                          "value": "Business event",
                                        },
                                        {
                                          "display":
                                              "Visual Arts Event",
                                          "value":
                                              "Visual Arts Event",
                                        },
                                        {
                                          "display": "Dance event",
                                          "value": "Dance event",
                                        },
                                        {
                                          "display": "Festival",
                                          "value": "Festival",
                                        }
                                      ],
                                      textField: 'display',
                                      valueField: 'display',
                                      filterable: true,
                                      required: false,
                                      value: null,
                                      onSaved: (value) {
                                        // addPreferenceType(value, "Festival and event");
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new MultiSelect(
                                      autovalidate: true,
                                      titleText: "Tour",
                                      enabeled: !_status,
                                      user: widget.user,
                                      initialValue: _preferenceTour,
                                      dataSource: [
                                        {
                                          "display": "Cycling tour",
                                          "value": "Cycling tour",
                                        },
                                        {
                                          "display": "Fluvial or sea tour",
                                          "value": "Fluvial Tour",
                                        },
                                        {
                                          "display": "Horse tour",
                                          "value": "Horse tour",
                                        },
                                        {
                                          "display": "Road tour",
                                          "value": "Road tour",
                                        },
                                        {
                                          "display": "Walking tour",
                                          "value": "Walking tour",
                                        }
                                      ],
                                      textField: 'display',
                                      valueField: 'display',
                                      filterable: true,
                                      required: false,
                                      value: null,
                                      onSaved: (value) {
                                        // addPreferenceType(value, "Tour");
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0, bottom: 25),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new MultiSelect(
                                      autovalidate: true,
                                      titleText: "Transport",
                                      enabeled: !_status,
                                      user: widget.user,
                                      initialValue: _preferenceTransport,
                                      dataSource: [
                                        {
                                          "display": "Airfield",
                                          "value": "Airfield",
                                        },
                                        {
                                          "display": "Airport",
                                          "value": "Airport",
                                        },
                                        {
                                          "display": "Bike station or depot",
                                          "value": "Bike station or depot",
                                        },
                                        {
                                          "display": "Bus station",
                                          "value": "Bus station",
                                        },
                                        {
                                          "display": "Public transport stop",
                                          "value": "Public transport stop",
                                        },
                                        {
                                          "display": "Cable car station",
                                          "value": "Cable car station",
                                        },
                                        {
                                          "display": "Carpool area",
                                          "value": "Carpool area",
                                        },
                                        {
                                          "display": "Lock",
                                          "value": "Lock",
                                        },
                                        {
                                          "display": "Parking",
                                          "value": "Parking",
                                        },
                                        {
                                          "display": "River port",
                                          "value": "River port",
                                        },
                                        {
                                          "display": "Seaport",
                                          "value": "Seaport",
                                        },
                                        {
                                          "display": "Taxi station",
                                          "value": "Taxi station",
                                        },
                                        {
                                          "display": "Train station",
                                          "value": "Train station",
                                        }
                                      ],
                                      textField: 'display',
                                      valueField: 'display',
                                      filterable: true,
                                      required: false,
                                      value: null,
                                      onSaved: (value) {
                                        //addPreferenceType(value, "Transport");
                                      }),
                                ),
                              ],
                            ),
                          ),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 0.0, bottom: 1),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                  child: new RaisedButton(
                child: Row(
                  mainAxisAlignment: prefix0.MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    new Text(
                      "Cancel",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                textColor: Colors.white,
                color: Color.fromARGB(255, 30, 110, 160),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.white,
        radius: 17.0,
        child: new Icon(
          Icons.edit,
          color: Color.fromARGB(255, 30, 110, 160),
          size: 25.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
