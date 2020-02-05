import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:integration_firbase/setup/sign_in.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password, _username;
  String _sexe = "";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<dynamic> documents = [
    "Accommodation",
    "Cultural site",
    "Festival and event",
    "Food establishment",
    "Natural heritage",
    "Tour",
    "Transport"
  ];

  void _forSexe(String value) {
    setState(() {
      _sexe = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/fr2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
            child: Container(
                height: 500,
                width: 350,
                child: Card(
                    color: Color.fromARGB(88, 185, 215, 255),
                    margin: EdgeInsets.all(15),
                    elevation: 10.0,
                    child: Center(
                      child: Container(
                        padding: new EdgeInsets.all(14.0),
                        child: Form(
                            key: _formkey,
                            child: ListView(
                              padding: EdgeInsets.only(top: 10.0),
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Registration",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30.0,
                                            letterSpacing: 2,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, -3.0),
                                                blurRadius: 12.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                              Shadow(
                                                offset: Offset(0.0, -3.0),
                                                blurRadius: 7.0,
                                                color: Color.fromARGB(
                                                    125, 0, 0, 255),
                                              ),
                                            ],
                                            fontStyle: FontStyle.normal)),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Please type an Username';
                                        }
                                      },
                                      onSaved: (input) => _username = input,
                                      decoration: InputDecoration(
                                        labelText: 'Username',
                                      ),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                    TextFormField(
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Please type an email';
                                        }
                                      },
                                      onSaved: (input) => _email = input,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                      ),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                    TextFormField(
                                      validator: (input) {
                                        if (input.length < 6) {
                                          return 'Your password needs to be atleast 6 characters';
                                        }
                                      },
                                      onSaved: (input) => _password = input,
                                      decoration: InputDecoration(
                                          labelText: 'Password'),
                                      obscureText: true,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                    TextFormField(
                                      validator: (input) {
                                        if (input.length < 6) {
                                          return 'Your password must be confirmed';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Confirm your Password'),
                                      obscureText: true,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: new RadioListTile(
                                            value: "Male",
                                            title: new Text(
                                              "Male",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            groupValue: _sexe,
                                            activeColor: Colors.white,
                                            onChanged: (String value) {
                                              _forSexe(value);
                                            },
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: new RadioListTile(
                                            value: "Female",
                                            title: new Text(
                                              "Female",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            groupValue: _sexe,
                                            activeColor: Colors.white,
                                            onChanged: (String value) {
                                              _forSexe(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    new MaterialButton(
                                      height: 36.0,
                                      minWidth: 120.0,
                                      elevation: 10.0,
                                      color: Color.fromARGB(255, 45, 120, 170),
                                      child: new Text('Sign Up',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, -1.0),
                                                blurRadius: 1.0,
                                                color: Color.fromARGB(
                                                    255, 30, 110, 160),
                                              ),
                                            ],
                                          )),
                                      onPressed: signUp,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    )))),
      ]),
    );
  }

  Future<void> signUp() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      Map<String, dynamic> userData = new Map<String, dynamic>();
      userData["Name"] = _username;
      userData["Sexe"] = _sexe;
      userData["role"] = "member";

      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);

        FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;

        DocumentReference currentUid =
            Firestore.instance.collection("users").document('${user.uid}');
        Firestore.instance.runTransaction((transaction) async {
          await transaction.set(currentUid, userData);
          print("instance created");
        });
        creatCollections(user);
        creatRatingcollection(user);
 /* Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Navigattoscreen(
                      user: user,
                    )));*/
       Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void creatCollections(FirebaseUser user) {
    Map<String, dynamic> preferenceType = new Map<String, dynamic>();
    
    for (var i = 0; i < documents.length; i++) {
     preferenceType[documents[i]] = null;
    }
     DocumentReference currentUser =Firestore.instance.collection("Preference").document('${user.uid}');
      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(currentUser, preferenceType);
      });
  }
  void creatRatingcollection(FirebaseUser user) {
    Map<String, int> itemRating = new Map<String, int>();
    itemRating["title"] = 0;
    
     DocumentReference currentUser =Firestore.instance.collection("Rating").document('${user.uid}');
      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(currentUser, itemRating);
      });
  }
}
