import 'package:flutter/material.dart';

import 'package:medicaid/screens/voice_login.dart';
import 'package:medicaid/screens/member_registration.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';

class LandingPage extends StatefulWidget {
  // defining the route here
  static final routeName = "/landingPage";

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // defining the login button widget
  bool isRegistered=false;

  Widget loginButton() {
    checkIfUserRegistered();

    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        //onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName, ModalRoute.withName(HomePage.routeName)),
        onPressed: () => isRegistered? Navigator.of(context).pushNamed(VoiceLogin.routeName):showErrorDialog(),
        child: Text(
          "Login",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        shape: StadiumBorder(
          side: BorderSide(
            width: 1.0,
            color: Color(0XFF00AFDF),
          ),
        ),
      ),
    );
  }

  // defining the register button widget
  Widget registerButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF1EE3B7),
        onPressed: () =>
            Navigator.of(context).pushNamed(MemberRegistration.routeName),
          //  Navigator.of(context).pushNamed(VoiceRegistrationSetUp.routeName),
        child: Text(
          "Register",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        shape: StadiumBorder(
          side: BorderSide(
            width: 1.0,
            color: Color(0XFF1EE3B7),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //logo(),
            CommonWidgets.spacer(gapHeight: 20.0),
            Text(
              "Welcome!",
              style: TextStyle(
                color: Color(0XFF00AFDF),
                fontSize: 34.0,
              ),
            ),
            CommonWidgets.spacer(gapHeight: 15.0),
            Text(
              "Please log in to continue.",
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            CommonWidgets.spacer(gapHeight: 10.0),
            Text(
              "Don't have any account?",
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            Text(
              "Please register for one.",
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            CommonWidgets.spacer(gapHeight: 80.0),
            loginButton(),
            CommonWidgets.spacer(gapHeight: 25.0),
            registerButton(),
            CommonWidgets.spacer(gapHeight: 20.0),
          ],
        ),
      ),
    ));
  }

  void checkIfUserRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(    prefs.getBool("is registered") != null &&   prefs.getBool("is registered") !=false){
      isRegistered=true;
    }
  }

  void showErrorDialog() {
      showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "You haven't registered yet!!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.0),
                    ),
                    Divider(
                     height: 2.0,

                    )
                  ],
                ),
              ),
              content: Container(
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Please register before logging in.",

                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    CommonWidgets.spacer(gapHeight: 25.0),
                    RaisedButton(
                        color: Color(0XFF00AFDF),
                        shape: StadiumBorder(
                          side: BorderSide(
                            width: 1.0,
                            color: Color(0XFF00AFDF),
                          ),
                        ),
                        child: Text(
                            "OK",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0
                            )
                        ),
                        onPressed:
                        ()=>Navigator.of(context).pop()

                    )
                  ],
                ),
              ));
        },
    );
  }
}
