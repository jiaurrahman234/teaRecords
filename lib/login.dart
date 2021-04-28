import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tea_records/SplashScreen.dart';
import 'package:tea_records/inputWidget/inputWidget.dart';

import 'dashboard.dart';

class Login extends StatelessWidget {

  Widget titleSection = Container(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom:8),
                  child: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Address",
                  style: TextStyle(color: Colors.green),
                )
              ],
          ),
        ),
        Icon(
          Icons.star
        ),
        Text(
            "49"
        )
      ],
    ),
  );

  Widget roundedRectButton(
      String title, List<Color> gradient, bool isEndIconVisible) {
    return Builder(builder: (BuildContext mContext) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {
            /*Scaffold.of(mContext).showSnackBar(SnackBar(
              content: Text('Tap'),
            ));*/
            Navigator.pushReplacement(mContext, MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
          },
          child: Stack(
            alignment: Alignment(1.0, 0.0),
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(mContext).size.width / 1.7,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                padding: EdgeInsets.only(top: 16, bottom: 16),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                      Icons.forward
                  )
              ),
            ],
          ),
        ),
      );
    });
  }

  static const List<Color> signInGradients = [
    Color(0xFF0EDED2),
    Color(0xFF03A0FE),
  ];

  static const List<Color> signUpGradients = [
    Color(0xFFFF9945),
    Color(0xFFFc6076),
  ];

  Widget loginForm(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Image.asset(
            'assets/images/logo.jpg',
            height: 200,
            width: 200,
          ),

          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              InputWidget("Enter username",30.0, 0.0),
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              'Enter username',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.black,
                                  fontSize: 12),
                            ),
                          )),

                    ],
                  ))
            ],
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 20),
              ),
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              InputWidget("Enter password",30.0, 0.0),
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              'Enter password',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.black,
                                  fontSize: 12),
                            ),
                          )),
                      /*Container(
                        padding: EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          gradient: LinearGradient(
                              colors: signInGradients,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: Icon(
                            Icons.arrow_forward
                        ),
                      )*/
                    ],
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
          ),
          roundedRectButton("Login", signInGradients, false),
          //roundedRectButton("Create an Account", signUpGradients, false),

        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: loginForm(context)
      ),
    );
  }
}