import 'package:flutter/material.dart';
import 'package:integration_firbase/Page/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'France tourism',
      theme: ThemeData(
          primaryColor: Colors.white,          
          appBarTheme: AppBarTheme(
              color: Color.fromARGB(255, 30, 110, 160),
              elevation: 1.5,
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 18)),
              iconTheme: IconThemeData(color: Colors.white)),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              // borderRadius: BorderRadius.circular(30.0)
            ),
          )),
      home: Welcome(),
      debugShowCheckedModeBanner: false
    );
  }
}
