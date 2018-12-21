import 'package:flutter/material.dart';

import 'package:medicaid/screens/home_page.dart';
import 'package:medicaid/screens/member_registration.dart';
import 'package:medicaid/utils/common_widgets.dart';

class LandingPage extends StatefulWidget {

  // defining the route here
  static final routeName = "/landingPage";

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  // defining the login button widget
  Widget loginButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName, ModalRoute.withName(HomePage.routeName)),
        child: Text(
          "Login",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white
          ),
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
        onPressed: () => Navigator.of(context).pushNamed(MemberRegistration.routeName),
        child: Text(
          "Register",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white
          ),
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
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey
                  ),
                ),
                CommonWidgets.spacer(gapHeight: 10.0),
                Text(
                  "Don't have any account?",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey
                  ),
                ),
                Text(
                  "Please register for one.",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey
                  ),
                ),
                CommonWidgets.spacer(gapHeight: 80.0),
                loginButton(),
                CommonWidgets.spacer(gapHeight: 25.0),
                registerButton(),
                CommonWidgets.spacer(gapHeight: 20.0),
              ],
            ),
          ),
        )
    );
  }
}
