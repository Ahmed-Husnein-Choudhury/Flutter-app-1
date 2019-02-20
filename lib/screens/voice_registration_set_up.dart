import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicaid/utils/common_widgets.dart';
//import 'package:simple_permissions/simple_permissions.dart';
import 'package:medicaid/screens/member_registration.dart';
import 'package:url_launcher/url_launcher.dart';
import 'voice_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicaid/screens/facial_login.dart';
import 'package:medicaid/screens/landing_page.dart';

class VoiceRegistrationSetUp extends StatefulWidget {
  static final String routeName = "/voiceRegistrationSetup";

  @override
  _State createState() => _State();
}

const _voiceRecognitionMethodChannel =
    const MethodChannel("biometric authentication");

class _State extends State<VoiceRegistrationSetUp> {
  Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.png",
        height: 100.0,
      ),
    );
  }

  Widget instructionalText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.0
      ),
    );
  }

  Widget continueButton() {
    return
      Padding(
        padding: EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 0.0),
        child: Container(
            height: 60,
            width: 250,
            child: RaisedButton(
                color: Color(0XFF00AFDF),
                shape: StadiumBorder(
                  side: BorderSide(
                    width: 0.5,
                    color: Color(0XFF00AFDF),
                  ),
                ),
                child: Text("Continue",
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                onPressed: requestPermission)));
  }

  requestPermission() async {

       _registerWithVoice();

  }

  Future<Null> _registerWithVoice() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool response;

//    fullName="Ahmed";
//    phoneNumber="264465";

    response = await _voiceRecognitionMethodChannel
        .invokeMethod("register voice", {"name": fullName,"phone number":phoneNumber});
    print("native is being called:$response");

    prefs.setBool("is registered", response);

    response
        ? 
    Navigator.of(context).pushNamed(LandingPage.routeName)
        : "not working";
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: exitApp,
        child: Scaffold(
            body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
          child:Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CommonWidgets.spacer(gapHeight: 20.0),
                CommonWidgets.logo(),
                CommonWidgets.spacer(gapHeight: 40.0),
                instructionalText(
                    "Almost Done! Let's add your voice recognition security."),
                CommonWidgets.spacer(gapHeight: 30.0),

              ],
            ),
            )
              ),

              Positioned(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: continueButton(),
                ),
              ),

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
            ]
          ),
        )));
  }

  Future<bool> exitApp() {
    print("app exited");
    exit(0);
  }
}
