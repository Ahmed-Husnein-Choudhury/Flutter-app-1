import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medicaid/screens/facial_login.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicalEmergency extends StatelessWidget {
  static final String routeName = "/medicalEmergencyScreen";

  Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.png",
        height: 100.0,
      ),
    );
  }

  // defining the instructional text widget
  Widget instructionalText() {
    return Center(
        child: Padding(
            padding:
                EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 0.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/warning.png",
                  height: 50,
                  width: 50,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 16.0,
                                  height: 1.0,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text:
                                        "If this is a medical emergency \nsituation, please call "),
                                TextSpan(
                                    text: "9-1-1",
                                    style: TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        String url = "tel:9-1-1";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      }),
                                TextSpan(text: "\nimmediately.")
                              ]),
                        )))
              ],
            )));
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
          RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 15.0, height: 1.2),
                  children: [
                TextSpan(
                    text: "Customer Service ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: '(800) 555-2222',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        String url = "tel:800555-2222";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }),
              ]))
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
          Text(
              "Your privacy is very important to us. We protect your personal health information as required by law."),
        ],
      ),
    );
  }

  Widget continueButton(BuildContext context) {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),

        ///the function below takes camera permission and then opens the camera

        onPressed: () {
          Navigator.of(context).pushNamed(FacialLogin.routeName);
        },
        child: Text(
          "Continue",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      children: <Widget>[
        Positioned(
            child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  CommonWidgets.spacer(gapHeight: 20.0),
                  logo(),
                  CommonWidgets.spacer(gapHeight: 30.0),
                  instructionalText(),
                  CommonWidgets.spacer(gapHeight: 30.0),
                  continueButton(context),
                ]))),
        Positioned(
            child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        healthPlanLabel(),
                        CommonWidgets.spacer(gapHeight: 20.0),
                        bottomPrivacyTextLabel(),
                      ],
                    ))))
      ],
    )));
  }
}
