import 'package:flutter/material.dart';
import 'package:medicaid/utils/common_widgets.dart';

class FacialRecognitionSetup extends StatefulWidget {

  // defining the route here
  static final String routeName = "/facialRecognitioSetup";

  @override
  _FacialRecognitionSetupState createState() => _FacialRecognitionSetupState();
}

class _FacialRecognitionSetupState extends State<FacialRecognitionSetup> {

  // widget for showing logo
  Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.jpg",
        height: 100.0,
      ),
    );
  }

  // defining the instructional text widget
  Widget instructionalText() {
    return Text(
      "Let's get started Setting up extra authentication is required for you to receive the best experience with this"
          " app. In order to help protect your privacy, you must provide two additional levels of authentication. "
          "This should take less than 30 seconds to complete. To continue, press: Let's get started",
      style: TextStyle(
          fontSize: 15.0,
      ),
    );
  }

  // defining the health plan details text widget
  Widget healthPlanLabel() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Health Plan 1"),
          CommonWidgets.spacer(gapHeight: 5.0),
          Text("Customer Service (800) 555-2222"),
        ],
      ),
    );
  }

  // defining the privacy text details text widget
  Widget bottomPrivacyTextLabel() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Your privacy is very important to use. We protect your personal health information as required by law."),
        ],
      ),
    );
  }

  Widget getStartedButton() {
    return MaterialButton(
      onPressed: null,
      height: 40.0,
      padding: EdgeInsets.all(15.0),
      minWidth: 200.0,
      color: Color(0XFF00AFDF),
      textColor: Colors.white,
      child: Text(
        "Let's get started",
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      shape: Border.all(width: 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                CommonWidgets.spacer(gapHeight: 20.0),
                logo(),
                CommonWidgets.spacer(gapHeight: 30.0),
                instructionalText(),
                CommonWidgets.spacer(gapHeight: 50.0),
                getStartedButton(),
                CommonWidgets.spacer(gapHeight: 30.0),
                healthPlanLabel(),
                CommonWidgets.spacer(gapHeight: 30.0),
                bottomPrivacyTextLabel(),
                CommonWidgets.spacer(gapHeight: 20.0),
              ],
            ),
          ),
        ));
  }
}
