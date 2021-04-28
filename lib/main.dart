import 'package:flutter/material.dart';
import 'package:tea_records/SplashScreen.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      //backgroundColor: Color(0xff00BCD1),
      theme: ThemeData(
          primarySwatch: Colors.red,
          backgroundColor: Colors.green,
          //brightness: Brightness.dark,

          /*primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],*/
        /*textTheme: TextTheme(
          headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 10, color: Colors.red),
        ),*/
      ),
      home: SplashScreen(),
    );
  }
}