import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:medicaid/screens/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class VoiceLogin extends StatefulWidget {

  static final String routeName="/voiceLogin";

  @override
  _State createState() => _State();
}

const _voiceLoginMethodChannel = const MethodChannel("biometric authentication");

class _State extends State<VoiceLogin> {

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

    );
  }

  Widget continueButton() {
    return
      Padding(
          padding: EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 0.0),
          child: Container(
              height: 45,
              width: 200,
              child:RaisedButton(
                  color: Color(0XFF00AFDF),
                  shape: StadiumBorder(
                    side: BorderSide(
                      width: 0.5,
                      color: Color(0XFF00AFDF),
                    ),
                  ),
                  child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0
                      )
                  ),
                  onPressed: requestPermission

              )
          )
      );
  }

  requestPermission() async {
    final res = await SimplePermissions.requestPermission(Permission.RecordAudio);
    if (res==PermissionStatus.authorized) {
      print("audio permission granted:$res");
      final req = await SimplePermissions.requestPermission(
          Permission.WriteExternalStorage);
      if (req==PermissionStatus.authorized) {
        _loginWithVoice();
      }
    }
  }

  Future<Null> _loginWithVoice() async {
    bool response = await _voiceLoginMethodChannel.invokeMethod("login using voice");
    print("log response: $response");
    if (response) {

      Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName, ModalRoute.withName(HomePage.routeName));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child:Column(
              children: <Widget>[
                CommonWidgets.spacer(gapHeight: 20.0),
                CommonWidgets.logo(),
                CommonWidgets.spacer(gapHeight: 30.0),
                instructionalText("Great! We were able to verify the first biometric. "
                    "Please click continue to move to the next verification step."),
                CommonWidgets.spacer(gapHeight: 30.0),
                continueButton(),
                CommonWidgets.spacer(gapHeight: 20.0),
                instructionalText("Health Plan Service 1"),
                instructionalRichText(),
                CommonWidgets.spacer(gapHeight: 50.0),
                instructionalText("Your privacy is very important to use. "
                    "We protect your personal health information as required by law"),
              ],
            ),
          ),
        ));

  }

  Future<bool> exitApp() {
    print("app exited");
    exit(0);
  }

  Widget instructionalRichText() {

    return RichText(text: TextSpan(style: TextStyle(fontSize: 14.0,height: 1.2),
        children: [
          TextSpan(text:"Customer Service ",style: TextStyle(color: Colors.black)),
          TextSpan(
              text: '(800) 555-2222',
              style: new TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = () async {
                String url = "tel:800555-2222";
                if (await canLaunch(url)) {
                  await launch(url);
                } else{
                  throw 'Could not launch $url';
                }
              }
          ),
        ]
    ));

  }
}
