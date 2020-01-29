import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:integration_firbase/Page/pageDetail.dart';
import 'package:integration_firbase/model_json/model_result.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';

class Filter extends StatefulWidget {
  final String name;
  final String myImg;
  final FirebaseUser user;
  Filter({this.name, this.myImg, @required this.user});
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String img;

  List<String> classement = [
    "    ",
    "Economic        ",
    "Moyen    ",
    "Lux    "
  ];
  String _classement = "    ";
  List<String> path = [
    "    ",
    "Long              ",
    "Medium           ",
    "Small           "
  ];
  String _path = "    ";
  List<String> tourType = [
    "    ",
    "Loop itinerary          ",
    "Open jaw itinerary             ",
    "Round Trip  "
  ];

  void selectedItem(String value) {
    setState(() {
      _classement = value;
    });
  }

  void selectedPath(String value) {
    setState(() {
      _path = value;
    });
  }

  String _grp1 = "";
  void mobility(String value) {
    setState(() {
      _grp1 = value;
    });
  }

  String _grp2 = "";
  void takeaway(String value) {
    setState(() {
      _grp2 = value;
    });
  }

  @override
  void initState() {
    super.initState();
    img = widget.myImg;
    getThesaurus();

    setState(() {
      selectCompSet();
      loading = false;
      msgOfConflit = "Add constraints to get personalized recommendation";
      isCompatibal = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    getFiltres();
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Color.fromARGB(250, 5, 101, 156),
        elevation: 1.5,
        actions: <Widget>[
          new Container(),
        ],
      ),
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.84,
        child: Drawer(
            key: _drawerKey,
            elevation: 20.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 85,
                  child: DrawerHeader(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Center(
                        child: Text(
                      "Filters",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    )),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(250, 5, 101, 156),
                    ),
                  ),
                ),
                Container(
                  height: 800,
                  padding: EdgeInsets.only(top: 0, left: 15, right: 15),
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          loading
                              ? CircularProgressIndicator()
                              : searchTextField0 =
                                  AutoCompleteTextField<String>(
                                  key: key,
                                  clearOnSubmit: false,
                                  suggestions: theme,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(250, 5, 101, 156),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        1.0, 5.0, 2.0, 10.0),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.black54,
                                        size: 20,
                                      ),
                                      tooltip: "Clear",
                                      onPressed: () {
                                        searchTextField0.textField.controller
                                            .clear();
                                        controllerTheme = null;
                                      },
                                    ),
                                    labelText: "Theme",
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(250, 5, 101, 156),
                                        fontSize: 15),
                                  ),
                                  itemFilter: (item, query) {
                                    return item
                                        .toLowerCase()
                                        .startsWith(query.toLowerCase());
                                  },
                                  itemSorter: (a, b) {
                                    return a.compareTo(b);
                                  },
                                  itemSubmitted: (item) {
                                    setState(() {
                                      searchTextField0
                                          .textField.controller.text = item;

                                      controllerTheme = searchTextField0
                                          .textField.controller.text;
                                      /* if (hasError == false) {
                                        theError = controllerTheme;
                                      }*/
                                    });
                                  },
                                  itemBuilder: (context, item) {
                                    return row(item);
                                  },
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          loading
                              ? CircularProgressIndicator()
                              : searchTextField1 =
                                  AutoCompleteTextField<String>(
                                  key: keyEquipped,
                                  clearOnSubmit: false,
                                  suggestions: equipped,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(250, 5, 101, 156),
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(1.0, 2.0, 2.0, 2.0),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.black54,
                                        size: 20,
                                      ),
                                      tooltip: "Clear",
                                      onPressed: () {
                                        searchTextField1.textField.controller
                                            .clear();
                                        controllerEquipped = null;
                                      },
                                    ),
                                    labelText: "Equipped with",
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(250, 5, 101, 156),
                                        fontSize: 15),
                                  ),
                                  itemFilter: (item, query) {
                                    return item
                                        .toLowerCase()
                                        .startsWith(query.toLowerCase());
                                  },
                                  itemSorter: (a, b) {
                                    return a.compareTo(b);
                                  },
                                  itemSubmitted: (item) {
                                    setState(() {
                                      searchTextField1
                                          .textField.controller.text = item;
                                      controllerEquipped = searchTextField1
                                          .textField.controller.text;
                                      /*if (hasError == false) {
                                        theError = controllerEquipped;
                                      }*/
                                    });
                                  },
                                  itemBuilder: (context, item) {
                                    return row(item);
                                  },
                                ),
                          SizedBox(
                            height: 25,
                          ),
                          new Text(
                            "Geographic environment",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(250, 5, 101, 156),
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10, top: 0),
                            height: 50,
                            width: 280,
                            child: DropdownButton<String>(
                              value: selectedEnvironment.isEmpty
                                  ? null
                                  : selectedEnvironment.last,
                              onChanged: (String newValue) {
                                setState(() {
                                  if (selectedEnvironment.contains(newValue)) {
                                    selectedEnvironment.remove(newValue);
                                    s--;
                                  } else {
                                    selectedEnvironment.add(newValue);
                                    s++;
                                  }
                                });
                              },
                              items: environment.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 18,
                                        color:
                                            selectedEnvironment.contains(value)
                                                ? null
                                                : Colors.transparent,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(width: 66),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          new Text(
                            "Proposes as a means of payment",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(250, 5, 101, 156),
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10, top: 0),
                            height: 50,
                            width: 280,
                            child: DropdownButton<String>(
                              value: selectedPayment.isEmpty
                                  ? null
                                  : selectedPayment.last,
                              onChanged: (String newValue) {
                                setState(() {
                                  if (selectedPayment.contains(newValue)) {
                                    selectedPayment.remove(newValue);
                                    j--;
                                  } else {
                                    selectedPayment.add(newValue);
                                    j++;
                                  }
                                });
                              },
                              items: payment.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 18,
                                        color: selectedPayment.contains(value)
                                            ? null
                                            : Colors.transparent,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(width: 48),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          new Text(
                            "Reduce mobility access",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(250, 5, 101, 156),
                            ),
                          ),
                          new Row(
                            children: <Widget>[
                              Expanded(
                                child: new RadioListTile(
                                  value: "false",
                                  selected: true,
                                  title: new Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  groupValue: _grp1,
                                  activeColor: Color.fromARGB(250, 5, 101, 156),
                                  onChanged: (String value) {
                                    mobility(value);
                                  },
                                ),
                              ),
                              Expanded(
                                child: new RadioListTile(
                                  value: "true",
                                  title: new Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  groupValue: _grp1,
                                  activeColor: Color.fromARGB(250, 5, 101, 156),
                                  onChanged: (String value) {
                                    mobility(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "About classification    ",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(250, 5, 101, 156),
                                ),
                              ),
                              Container(
                                child: new DropdownButton(
                                  onChanged: (String value) {
                                    selectedItem(value);
                                  },
                                  isDense: false,
                                  value: _classement,
                                  items: classement.map((String val) {
                                    return new DropdownMenuItem(
                                      value: val,
                                      child: new Text(
                                        val,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          new Text(
                            "Kitchen Types",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(250, 5, 101, 156),
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10, top: 0),
                            height: 50,
                            width: 280,
                            child: DropdownButton<String>(
                              value: selectedCuisine.isEmpty
                                  ? null
                                  : selectedCuisine.last,
                              onChanged: (String newValue) {
                                setState(() {
                                  if (selectedCuisine.contains(newValue)) {
                                    selectedCuisine.remove(newValue);
                                    k--;
                                  } else {
                                    selectedCuisine.add(newValue);
                                    k++;
                                  }
                                });
                              },
                              items: cuisine.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 18,
                                        color: selectedCuisine.contains(value)
                                            ? null
                                            : Colors.transparent,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(width: 48),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          new Text(
                            "Takeaway",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(250, 5, 101, 156),
                            ),
                          ),
                          new Row(
                            children: <Widget>[
                              Expanded(
                                child: new RadioListTile(
                                  value: "false",
                                  selected: true,
                                  title: new Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  groupValue: _grp2,
                                  activeColor: Color.fromARGB(250, 5, 101, 156),
                                  onChanged: (String value) {
                                    takeaway(value);
                                  },
                                ),
                              ),
                              Expanded(
                                child: new RadioListTile(
                                  value: "true",
                                  title: new Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  groupValue: _grp2,
                                  activeColor: Color.fromARGB(250, 5, 101, 156),
                                  onChanged: (String value) {
                                    takeaway(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          new Text(
                            "Architectural Style",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(250, 5, 101, 156),
                            ),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10, top: 0),
                            height: 50,
                            width: 280,
                            child: DropdownButton<String>(
                              value: selectedStyle.isEmpty
                                  ? null
                                  : selectedStyle.last,
                              onChanged: (String newValue) {
                                setState(() {
                                  if (selectedStyle.contains(newValue)) {
                                    selectedStyle.remove(newValue);
                                    l--;
                                  } else {
                                    selectedStyle.add(newValue);
                                    l++;
                                  }
                                });
                              },
                              items: style.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 18,
                                        color: selectedStyle.contains(value)
                                            ? null
                                            : Colors.transparent,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(width: 67),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "Hike path distance      ",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(250, 5, 101, 156),
                                ),
                              ),
                              Container(
                                child: new DropdownButton(
                                  onChanged: (String value) {
                                    selectedPath(value);
                                  },
                                  isDense: false,
                                  value: _path,
                                  items: path.map((String val) {
                                    return new DropdownMenuItem(
                                      value: val,
                                      child: new Text(
                                        val,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "global path duration",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(250, 5, 101, 156),
                                ),
                              ),
                            ],
                          ),
                          //reset
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
      body: ListView(children: <Widget>[
        new Hero(
          tag: widget.name,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/fr2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            height: 636,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 193,
                  width: maxWidth,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(190, 0, 0, 0),
                    image: new DecorationImage(
                        fit: BoxFit.fitWidth,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstATop),
                        image: AssetImage("img/$img")),
                  ),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Column(children: <Widget>[
                          Builder(builder: (context) {
                            return Container(
                              margin: EdgeInsets.only(left: 12, top: 145),
                              child: MaterialButton(
                                height: 31.0,
                                minWidth: 18.0,
                                elevation: 7.0,
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.add_box,
                                      color: Color.fromARGB(250, 30, 110, 160),
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    new Text('Filtter',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                250, 30, 110, 160),
                                            fontSize: 18.0)),
                                  ],
                                ),
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                              ),
                            );
                          }),
                        ]),
                        Container(
                          margin: EdgeInsets.only(top: 145, left: 4),
                          child: MaterialButton(
                            height: 31.0,
                            minWidth: 18.0,
                            elevation: 7.0,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                new Text('Near me',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(250, 30, 110, 160),
                                        fontSize: 18.0)),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4, top: 145),
                          child: MaterialButton(
                            height: 31.0,
                            minWidth: 20.0,
                            elevation: 7.0,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                new Text('Rating',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(250, 30, 110, 160),
                                        fontSize: 18.0)),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 425,
                  child: Card(
                    color: Color.fromARGB(88, 185, 215, 255),
                    margin: EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 15,
                    ),
                    elevation: 3,
                    child: FutureBuilder(
                        future: _getListDataTourism(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return Container(
                              child: Center(
                                child: CollectionScaleTransition(
                                  children: <Widget>[
                                    Text(
                                      "L",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      "o",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      "a",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      "d",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      "i",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      "n",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      "g",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      ".",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    Text(
                                      ".",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    Text(
                                      ".",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            if (snapshot.data.length == 0) {
                              print("no result");
                              relaxMsg = "Relaxation";
                              msgOfConflit =
                                  "You have to relax your qurey in  " +
                                      cR[cR.length - 1].toString();
                              controllerTheme = "";

                              if (cR[cR.length - 1].toString() == "Theme") {
                                controllerTheme = "";
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    msg = "0";
                                    return Container(
                                      height: 170,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Card(
                                            elevation: 2,
                                            margin: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 10,
                                                bottom: 0),
                                            child: Container(
                                              height: 150,
                                              width: 340,
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 10,
                                                  bottom: 1),
                                              child: ListView(
                                                children: <Widget>[
                                                  Text(relaxMsg,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              250,
                                                              30,
                                                              110,
                                                              160),
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  Text("___________________",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              250,
                                                              30,
                                                              110,
                                                              160),
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text("Total: $total",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text("Matched items: $msg",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    msgOfConflit,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container(
                                    child: Center(
                                      child: CollectionScaleTransition(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 150,
                                          ),
                                          Text(
                                            "L",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "o",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "a",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "d",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "i",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "n",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "g",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            ".",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            ".",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            ".",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );

                              /****************************************** */

                            } else {
                              print(snapshot.data.length);
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    if (isCompatibal == false) {
                                      msg = "0";
                                    }
                                    return Container(
                                      height: 170,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Card(
                                            elevation: 2,
                                            margin: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 10,
                                                bottom: 0),
                                            child: Container(
                                              height: 150,
                                              width: 340,
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 10,
                                                  bottom: 1),
                                              child: ListView(
                                                children: <Widget>[
                                                  Text("Explanation",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              250,
                                                              30,
                                                              110,
                                                              160),
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  Text("___________________",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              250,
                                                              30,
                                                              110,
                                                              160),
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text("Total: $total",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text("Matched items: $msg",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    msgOfConflit,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // ),
                                    );
                                  }
                                  return Card(
                                    elevation: 2,
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 10),
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data[index].rdfslabel
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color:
                                              Color.fromARGB(250, 30, 110, 160),
                                        ),
                                      ),
                                      subtitle: Text(snapshot
                                          .data[index].schemaAddressLocality
                                          .toString()),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                        snapshot.data[index],
                                                        index,
                                                        widget.user),
                                                fullscreenDialog: true));
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _ackAlert(context);
        },
        child: Icon(
          Icons.settings,
        ),
        backgroundColor: Color.fromARGB(250, 30, 110, 160),
      ),
    );
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Possible filters',
            style: TextStyle(
              color: Color.fromARGB(250, 30, 110, 160),
            ),
          ),
          content: getTextWidgets(myCompSet['Compatible-with']),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(
                    color: Color.fromARGB(250, 30, 110, 160), fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget getTextWidgets(var strings) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < strings.length; i++) {
      list.add(new Text(
        "- " + strings[i],
        style: TextStyle(fontSize: 16),
      ));
    }
    return Container(
      height: 133,
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: list),
    );
  }

  Widget row(String thesaurus) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          thesaurus,
          style: TextStyle(fontSize: 15.0),
        ),
        SizedBox(
          width: 5.0,
        ),
      ],
    );
  }

//declaration of input
  AutoCompleteTextField searchTextField0;
  AutoCompleteTextField searchTextField1;
  AutoCompleteTextField searchTextField2;
  bool loading = true;
  bool submit = true;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> keyEquipped = new GlobalKey();
  GlobalKey _drawerKey = GlobalKey();
  static List<String> theme = new List<String>();
  static List<String> equipped = new List<String>();
  static List<String> cuisine = new List<String>();
  static List<String> style = new List<String>();
  static List<String> environment = new List<String>();
  static List<String> payment = [
    "American express",
    "Blue card",
    "Cash",
    "Check",
    "Eurocard - mastercard",
    "French bons caf",
    "Holiday vouchers",
    "International money order"
  ];
  List<String> selectedPayment = new List<String>();
  String selectedPaymentone = "";
  int j = -1;
  List<String> selectedStyle = new List<String>();
  String selectedStyleone = "";
  int l = -1;
  List<String> selectedEnvironment = new List<String>();
  String selectedEnvironmentone = "";
  int s = -1;
  List<String> selectedCuisine = new List<String>();
  String selectedCuisineone = "";
  int k = -1;

  // get theasaurus ****************************************************************************/
  void getThesaurus() async {
    theme = [];
    equipped = [];
    cuisine = [];
    style = [];
    environment = [];

    selectedCuisine = [];
    selectedStyle = [];
    selectedEnvironment = [];
    selectedPayment = [];

    final myData = await rootBundle.loadString('assets/thesaurusEn.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    for (var j = 0; j < 1337; j++) {
      if (csvTable[j][2] == "dt:CuisineCategory") {
        setState(() {
          cuisine.add(csvTable[j][1]);
        });
      }
      if (csvTable[j][2] == "dt:ArchitecturalStyle") {
        setState(() {
          style.add(csvTable[j][1]);
        });
      }
      if (csvTable[j][2] == "dt:SpatialEnvironmentTheme") {
        setState(() {
          environment.add(csvTable[j][1]);
        });
      }
      if (csvTable[j][2] == "dt:CommonAmenity" ||
          csvTable[j][2] == "dt:AccommodationAmenity" ||
          csvTable[j][2] == "dt:RoomAmenity" ||
          csvTable[j][2] == "dt:CulturalHeritageAmenity" ||
          csvTable[j][2] == "dt:CateringAmenity" ||
          csvTable[j][2] == "dt:CampingAndCaravanningAmenity" ||
          csvTable[j][2] == "dt:CommonAmenity" ||
          csvTable[j][2] == "dt:InformativeAmenity" ||
          csvTable[j][2] == "dt:NaturalHeritageAmenity") {
        setState(() {
          equipped.add(csvTable[j][1]);
        });
      }
      if (csvTable[j][2] == "dt:CulturalTheme" ||
          csvTable[j][2] == "dt:EntertainmentAndEventTheme" ||
          csvTable[j][2] == "dt:ParkAndGardenTheme" ||
          csvTable[j][2] == "dt:SportsTheme" ||
          csvTable[j][2] == "dt:SpatialEnvironmentTheme" ||
          csvTable[j][2] == "dt:CuisineCategory") {
        setState(() {
          theme.add(csvTable[j][1]);
        });
      }
    }
  }

//***********************************************************************************************/
  String controllerTheme;
  String controllerEquipped;
  String controllerType;
  String msg;
  int total;

  //bool hasError = false;
  String theError;
  // get filters ********************************************************************************/
  void getFiltres() {
    final RenderBox box = _drawerKey.currentContext?.findRenderObject();
    if (box != null) {
      searchTextField1.textField.controller.text = controllerEquipped;
      searchTextField0.textField.controller.text = controllerTheme;
    }
  }

// get compatibility********************************************************************************/
  static bool isCompatibal;
  static String msgOfConflit;
  static String relaxMsg;
  static var myCompSet;
  Future selectCompSet() async {
    myCompSet = await Firestore.instance
        .collection("(in)compatibility")
        .document(widget.name)
        .get();
  }

  void checkCompatibilty(var myCR) async {
    int yy;
    for (var y = 0; y < myCompSet['Compatible-with'].length; y++) {
      //print("myCR: $myCR");
      //print(myCompSet['Compatible-with'][y]);
      yy = y;
      if (myCR == myCompSet['Compatible-with'][y]) {
        break;
      }
    }
    if (yy == myCompSet['Compatible-with'].length - 1) {
      if (myCR != myCompSet['Compatible-with'][yy - 1]) {
        if (isCompatibal != false) {
          setState(() {
            isCompatibal = false;
          });
        }
      } else {
        if (isCompatibal != true) {
          setState(() {
            isCompatibal = true;
          });
        }
      }
    } else {
      if (isCompatibal != true) {
        setState(() {
          isCompatibal = true;
        });
      }
    }
  }

// check cR****************************************************************************************/
  List<String> cR = [];
  void getCR() {
    //cR = [];
    //type------------------
    controllerType = widget.name;
    //theme----------------
    if (controllerTheme == null || controllerTheme == "") {
      controllerTheme = "";
    } else {
      cR.add("Theme");
    }
    //Equipped---------------
    if (controllerEquipped == null || controllerEquipped == "") {
      controllerEquipped = "";
    } else {
      cR.add("Equipment");
    }
    // geo enviro-------------
    if (selectedEnvironment.length != 0) {
      selectedEnvironmentone = selectedEnvironment[s];
      cR.add("Geographic Environment");
    } else {
      selectedEnvironmentone = "";
    }
    //Payment----------------
    if (selectedPayment.length != 0) {
      selectedPaymentone = selectedPayment[j];
      cR.add("Means of Payment");
    } else {
      selectedPaymentone = "";
    }
    //mobility access-------
    if (_grp1 != "") {
      cR.add("Mobility");
    }
    //Cuisine-Type----------
    if (selectedCuisine.length != 0) {
      selectedCuisineone = selectedCuisine[k];
      cR.add("Kitchen Types");
    } else {
      selectedCuisineone = "";
    }
    //has archiological style--------
    if (selectedStyle.length != 0) {
      selectedStyleone = selectedStyle[l];
      cR.add("Architectural Style");
    } else {
      selectedStyleone = "";
    }
  }
// get list datatourism ****************************************************************************/

  Future<List<Mydata>> _getListDataTourism() async {
    getCR();

    // chech compatibility ---------------------------------------------------------------------
    if (cR.length != 0) {
      checkCompatibilty(cR[cR.length - 1]);

      if (isCompatibal == true) {
        msgOfConflit =
            "The preview contains only the top 10 results of your query";
      } else {
        msgOfConflit =
            cR[cR.length - 1] + " not Compatibal with Type " + widget.name;
        if (cR[cR.length - 1] == "Theme") {
          controllerTheme = "";
        }
        if (cR[cR.length - 1] == "Equipment") {
          controllerEquipped = "";
        }
        if (cR[cR.length - 1] == "Geographic Environment") {
          selectedEnvironmentone = "";
          selectedEnvironment.clear();
          s = -1;
        }
        if (cR[cR.length - 1] == "Kitchen Types") {
          selectedCuisineone = "";
          selectedCuisine.clear();
          k = -1;
        }
        if (cR[cR.length - 1] == "Architectural Style") {
          selectedStyleone = "";
          selectedStyle.clear();
          l = -1;
        }

        // check element of conflict and clear

      }
    }
    // execution of query --------------------------------------------------------------
    final response_2 = await http
        .post("http://192.168.43.163/myweb_for_ontolo/get_data.php", body: {
      "myType": controllerType,
      "myTheme": controllerTheme,
      "Equipped": controllerEquipped,
      "Environment": selectedEnvironmentone,
      "Payment": selectedPaymentone,
      "Mobility": _grp1,
      "Cuisine": selectedCuisineone,
      "ArchiStyle": selectedStyleone,
    });
    final jsonResponse = json.decode(response_2.body);

    // pars results -----------------------------------------------------------------------
    List<Mydata> listTour = [];
    Tourism tour = new Tourism.fromJson(jsonResponse);
    String rdfslabel;
    String shortDescription;
    String archiStyle;
    String schemaAddressLocality;
    String rdfslabelreview;
    double schemalatitude;
    double schemalongitude;
    String foafhomepage;
    String schematelephone;
    String schemaemail;

    for (var i = 0; i < tour.data.poi.results.length; i++) {
      List<String> rdfslabelEquipped = [];
      List<String> rdfslabelOffres = [];
      List<String> rdfslabelTheme = [];
      List<String> cuisineType = [];

      //rdflabel----------------------------------------------------------------------------------
      rdfslabel = tour.data.poi.results[i].rdfslabel[0];

      //address-----------------------------------------------------------------------------------
      schemaAddressLocality = tour.data.poi.results[i].isLocatedAt[0]
          .schemaAddress[0].schemaAddressLocality[0];

      //description------------------------------------------------------------------------------
      if (tour.data.poi.results[i].hasDescription.length != 0 &&
          tour.data.poi.results[i].hasDescription[0].shortDescription != null) {
        shortDescription =
            tour.data.poi.results[i].hasDescription[0].shortDescription[0];
      } else {
        shortDescription = "No Description";
      }

      //cuisine type-----------------------------------------------------------------------------
      if (tour.data.poi.results[i].providesCuisineOfType.length != 0) {
        for (var j = 0;
            j < tour.data.poi.results[i].providesCuisineOfType.length;
            j++) {
          cuisineType.add(tour.data.poi.results[i].providesCuisineOfType[j]
              .rdfslabelCuisineOfType[0]);
        }
      } else {
        cuisineType.add("no special cuisine type");
      }

      //archiStyle------------------------------------------------------------------------------
      if (tour.data.poi.results[i].hasArchiStyle.length != 0 &&
          tour.data.poi.results[i].hasArchiStyle[0].rdfslabelArchiStyle !=
              null) {
        archiStyle =
            tour.data.poi.results[i].hasArchiStyle[0].rdfslabelArchiStyle[0];
      } else {
        archiStyle = "No archiStyle";
      }

      //theme----------------------------------------------------------------------------------
      if (tour.data.poi.results[i].hasTheme.length != 0) {
        for (var j = 0; j < tour.data.poi.results[i].hasTheme.length; j++) {
          rdfslabelTheme
              .add(tour.data.poi.results[i].hasTheme[j].rdfslabeltheme[0]);
        }
      } else {
        rdfslabelTheme.add("no details ");
      }
      //contacts ---------------------------------------------------------------------------
      if (tour.data.poi.results[i].hascontact.length != 0) {
        //website------------
        if (tour.data.poi.results[i].hascontact[0].foafhomepage != null) {
          foafhomepage = tour.data.poi.results[i].hascontact[0].foafhomepage[0];
        } else {
          foafhomepage = "no website";
        }
        //telephone----------
        if (tour.data.poi.results[i].hascontact[0].schematelephone != null) {
          schematelephone =
              tour.data.poi.results[i].hascontact[0].schematelephone[0];
        } else {
          schematelephone = "no telephone";
        }
        //email--------------
        if (tour.data.poi.results[i].hascontact[0].schemaemail != null) {
          schemaemail = tour.data.poi.results[i].hascontact[0].schemaemail[0];
        } else {
          schemaemail = "no email";
        }
      } else {
        foafhomepage = "no website";
        schematelephone = "no telephone";
        schemaemail = "no email";
      }

      //review------------------------------------------------------------------------------
      if (tour.data.poi.results[i].hasReview.length != 0) {
        if (tour.data.poi.results[i].hasReview[0].hasReviewValue.isNotEmpty) {
          rdfslabelreview = tour.data.poi.results[i].hasReview[0]
              .hasReviewValue[0].rdfslabelreview[0];
        }
      } else {
        rdfslabelreview = "no review";
      }

      //Equipped----------------------------------------------------------------------------
      if (tour.data.poi.results[i].isEquippedWith.length != 0) {
        for (var j = 0;
            j < tour.data.poi.results[i].isEquippedWith.length;
            j++) {
          rdfslabelEquipped.add(
              tour.data.poi.results[i].isEquippedWith[j].rdfslabelEquipped[0]);
        }
      } else {
        rdfslabelEquipped.add("no equipment");
      }

      //offres----------------------------------------------------------------------------
      if (tour.data.poi.results[i].offers.length != 0) {
        if (tour.data.poi.results[i].offers[0].schemaacceptedPaymentMethod
            .isNotEmpty) {
          for (var j = 0;
              j <
                  tour.data.poi.results[i].offers[0].schemaacceptedPaymentMethod
                      .length;
              j++) {
            rdfslabelOffres.add(tour.data.poi.results[i].offers[0]
                .schemaacceptedPaymentMethod[j].rdfslabelPayment[0]);
          }
        } else {
          rdfslabelOffres.add("no detail of type of payment");
        }
      } else {
        rdfslabelOffres.add("no detail of type of payment");
      }

      //location---------------------------------------------------------------------------
      schemalatitude = tour
          .data.poi.results[i].isLocatedAt[0].schemageo[0].schemalatitude[0];
      schemalongitude = tour
          .data.poi.results[i].isLocatedAt[0].schemageo[0].schemalongitude[0];
      // total --------------------------------------------------------------------------
      if (tour.data.poi.total != 0) {
        total = tour.data.poi.total;
        msg = total.toString();
      }

      Mydata mydata = Mydata(
        total,
        rdfslabel,
        shortDescription,
        cuisineType,
        archiStyle,
        rdfslabelTheme,
        foafhomepage,
        schematelephone,
        schemaemail,
        schemaAddressLocality,
        rdfslabelreview,
        rdfslabelOffres,
        rdfslabelEquipped,
        schemalatitude,
        schemalongitude,
      );
      listTour.add(mydata);
    }

    return listTour;
  }
}
