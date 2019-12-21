import 'package:flutter/material.dart';
import 'package:integration_firbase/setup/sign_in.dart';
import 'package:integration_firbase/setup/sign_up.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DATAtourist'),
        ),
        body: Stack(
          children: <Widget>[
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
                width: 340,
                child: Card(
                  color: Color.fromARGB(88, 185, 215, 255),
                  margin: EdgeInsets.all(5),
                  elevation: 5.0,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 260,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/datatourist.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              child: new MaterialButton(
                                height: 37.0,
                                minWidth: 110.0,
                                elevation: 5.0,
                                color: Colors.white,
                                child: new Text('Sign in',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(250, 30, 110, 160),
                                        fontSize: 20.0)),
                                onPressed: navigateToSingIn,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7),
                              child: new MaterialButton(
                                height: 37.0,
                                minWidth: 110.0,
                                color: Color.fromARGB(255, 45, 120, 170),
                                elevation: 5.0,
                                textColor: Colors.white,
                                child: new Text('Sign up',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0)),
                                onPressed: navigateToSingUp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            /* */
          ],
        ));
  }

  void navigateToSingIn() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSingUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}
