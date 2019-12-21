import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:integration_firbase/model_json/model_result.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Mydata mydatatour;
  final int index;
  final FirebaseUser user;
  DetailPage(this.mydatatour, this.index, this.user);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("can not launch $url");
    }
  }
  bool delete;
  @override
  void initState() {
    delete=true;
    super.initState();
  }
  /*----------------------------------------------------------------------------------------*/
   void _showRatingDialog() {
    // We use the built in showDialog function to show our Rating Dialog
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: Icon(Icons.rate_review,color: Color.fromARGB(240, 30, 110, 160),size: 50,),
               
            title: "Feedback",
            description:
                "Tap a star to set your rating. Add more description here if you want.",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "We are so happy :)", // optional
            negativeComment: "We're sad :(", // optional
            accentColor: Color.fromARGB(240, 30, 110, 160), // optional
            onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
              addRating(rating, widget.mydatatour.rdfslabel);
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
            },
          );
        });
  }

   void addRating( int rating, String title) async {
    Map<String, int> itemRating = new Map<String, int>();
    itemRating[title] = rating;
    print(itemRating);
    DocumentReference currentUser =Firestore.instance.collection("Rating").document('${widget.user.uid}');
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(currentUser, itemRating);
      });
      
    if(delete==true){
       Firestore.instance.collection('Rating').document('${widget.user.uid}').updateData({'title': FieldValue.delete()}).whenComplete((){
     print('Field Deleted');
     delete=false;
    });
    }
     
    }
  
/*----------------------------------------------------------------------------------------*/
  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Item Detail",
          // widget.mydatatour.rdfslabel,
          style: TextStyle(color: Colors.white, fontSize: 20),
          // textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/fr2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              height: 220,
              child: new FlutterMap(
                  options: new MapOptions(
                    center: new LatLng(widget.mydatatour.schemalatitude,
                        widget.mydatatour.schemalongitude),
                    zoom: 15,
                    //maxZoom: 19
                  ),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                        backgroundColor: Colors.white70),
                    new MarkerLayerOptions(markers: [
                      new Marker(
                          width: 60.0,
                          height: 110.0,
                          point: new LatLng(widget.mydatatour.schemalatitude,
                              widget.mydatatour.schemalongitude),
                          builder: (context) => new Container(
                                child: IconButton(
                                  icon: Icon(Icons.location_on),
                                  color: Color.fromARGB(250, 30, 110, 160),
                                  iconSize: 55.0,
                                  onPressed: () {
                                    print('Marker tapped');
                                  },
                                ),
                              ))
                    ])
                  ]),
            ),
            Row(
              mainAxisAlignment:  MainAxisAlignment.center,
                      children: <Widget>[
                       /* Column(children: <Widget>[
                          Builder(builder: (context) {
                            return Container(
                              margin: EdgeInsets.only(left: 4, ),
                              child: MaterialButton(
                                height: 31.0,
                                minWidth: 18.0,
                                elevation: 7.0,
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    new Text('Constraint',
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
                        ]),*/
                         Container(
                              margin: EdgeInsets.only( left: 4),
                              child: MaterialButton(
                                height: 31.0,
                                minWidth: 18.0,
                                elevation: 7.0,
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.favorite,
                                      color: Color.fromARGB(250, 30, 110, 160),
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    new Text('Save',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                250, 30, 110, 160),
                                            fontSize: 19.0)),
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4),
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
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    new Text('Rate',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                250, 30, 110, 160),
                                            fontSize: 19.0)),
                                  ],
                                ),
                                onPressed: _showRatingDialog,
                              ),
                            )
                      ],
                    ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,),
              child: Container(
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Titel",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color:
                                            Color.fromARGB(250, 30, 110, 160),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      widget.mydatatour.rdfslabel,
                                      //textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ],
                                  /* */
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "City",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                widget.mydatatour.schemaAddressLocality,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                         /* SizedBox(
                            height: 15,
                          ),*/
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             /* Text(
                                "Architecture Style",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                widget.mydatatour.archiStyle,
                                style: TextStyle(fontSize: 15.0),
                              ),*/
                            ],
                          ),
                         /* SizedBox(
                            height: 15,
                          ),*/
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             /* Text(
                                "Cuisine Type ",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              getTextWidgets(widget.mydatatour.cuisineType),
                             */
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                             "Geographic environments",// "Theme",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              getTextWidgets(widget.mydatatour.rdfslabeltheme),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                widget.mydatatour.shortDescription,
                                //textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Equipments",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              getTextWidgets(
                                  widget.mydatatour.rdfslabelEquipped),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Type of payments",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              getTextWidgets(
                                  widget.mydatatour.rdfslabelPayment),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Review",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "- " + widget.mydatatour.rdfslabelreview,
                                //textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Contact",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(250, 30, 110, 160),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "- Website: ",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: RaisedButton(
                                    color: Colors.white,
                                    elevation: 0.0,
                                    padding: EdgeInsets.all(0.0),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    child: Text(
                                      widget.mydatatour.foafhomepage,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.start,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () => {
                                          launchURL(
                                              widget.mydatatour.foafhomepage)
                                        }),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "- Email: ",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: RaisedButton(
                                    color: Colors.white,
                                    elevation: 0.0,
                                    padding: EdgeInsets.all(0.0),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    child: new GestureDetector(
                                      child: new Text(
                                        widget.mydatatour.schemaemail,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onLongPress: () {
                                        Clipboard.setData(new ClipboardData(
                                            text:
                                                widget.mydatatour.schemaemail));
                                        key.currentState
                                            .showSnackBar(new SnackBar(
                                          content:
                                              new Text("Copied to Clipboard"),
                                        ));
                                      },
                                    ),
                                    /*Text(
                                      widget.mydatatour.schemaemail,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.start,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),*/
                                    onPressed: () => {}),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "- Phone: ",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromARGB(250, 30, 110, 160),
                                ),
                              ),
                              new GestureDetector(
                                child:
                                    new Text(widget.mydatatour.schematelephone),
                                onLongPress: () {
                                  Clipboard.setData(new ClipboardData(
                                      text: widget.mydatatour.schematelephone));
                                  key.currentState.showSnackBar(new SnackBar(
                                    content: new Text("Copied to Clipboard"),
                                  ));
                                },
                              )
                              /*Text(
                                widget.mydatatour.schematelephone,
                                style: TextStyle(fontSize: 15.0),
                              ),*/
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextWidgets(List<String> strings) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < strings.length; i++) {
      list.add(new Text(
        "- " + strings[i],
        style: TextStyle(fontSize: 15),
      ));
    }
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  
}

