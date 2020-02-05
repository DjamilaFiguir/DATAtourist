import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integration_firbase/setup/navigattoscreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password,error;
  bool mybool=true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
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
                height: 450,
                width: 350,
                child: Card(
                    color: Color.fromARGB(88, 185, 215, 255),
                    margin: EdgeInsets.all(15),
                    elevation: 35.0,
                    child: Center(
                      child: Container(
                        padding: new EdgeInsets.all(14.0),
                        child: Form(
                          key: _formkey,
                          child: ListView(
                            padding: EdgeInsets.only(top: 30.0),
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("DATAtourist",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.0,
                                          letterSpacing: 2,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, -3.0),
                                              blurRadius: 12.0,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
                                    height: 30.0,
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
                                      suffixIcon: Icon(Icons.email,size:20,),
                                    ),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    validator: (input) {
                                      if (mybool==false) {
                                        return error;
                                      }
                                    },
                                    onSaved: (input) => _password = input,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      suffixIcon: Icon(Icons.vpn_key,size: 20,),
                                      // icon: Icon(Icons.vpn_key,size: 20,),
                                    ),
                                    obscureText: true,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  new MaterialButton(
                                    height: 36.0,
                                    minWidth: 120.0,
                                    elevation: 10.0,
                                    color: Colors
                                        .white, //Color.fromARGB(250, 5, 101, 156),
                                    textColor: Colors.white,
                                    child: new Text('Sign in',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 30, 110,160), //Colors.white,
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
                                    onPressed: signIn,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text("Forget your password?",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontStyle: FontStyle.normal)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )))),
      ]),
    );
  }

  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Navigattoscreen(
                      user: user,
                    )));
      } catch (e) {
       mybool=false;
       error= e.message;
        print(e.message);
      }
    }
  }

  

}
