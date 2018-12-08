import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {

  // defining the route here
  static final routeName = "/landingPage";

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  // widget for showing logo
  /*Widget logo() {
    return Image.asset(
      "assets/logo.jpg",
      height: 100.0,
    );
  }*/

  // dynamic gap widget
  Widget spacer({@required double gapHeight}) {
    return SizedBox(
      height: gapHeight,
    );
  }

  // defining the login button widget
  Widget loginButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: () => "something",
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
        onPressed: () => Navigator.of(context).pushNamed("/memberRegistration"),
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
                spacer(gapHeight: 20.0),
                Text(
                  "Welcome!",
                  style: TextStyle(
                    color: Color(0XFF00AFDF),
                    fontSize: 34.0,
                  ),
                ),
                spacer(gapHeight: 15.0),
                Text(
                  "Please log in to continue.",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey
                  ),
                ),
                spacer(gapHeight: 10.0),
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
                spacer(gapHeight: 80.0),
                loginButton(),
                spacer(gapHeight: 25.0),
                registerButton(),
                spacer(gapHeight: 20.0),
              ],
            ),
          ),
        )
    );
  }
}
