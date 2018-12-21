import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:medicaid/screens/member_registration.dart';
import 'voice_login.dart';

class VoiceRegistrationSetUp extends StatefulWidget {

  static final String routeName="/voiceRegistrationSetup";

  @override
  _State createState() => _State();
}

const _voiceRecognitionMethodChannel = const MethodChannel("biometric authentication");

class _State extends State<VoiceRegistrationSetUp> {

  Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.jpg",
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
    return Padding(
      padding: EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 0.0),
      child: Container(
        height: 45,
      width: 30,
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
        _registerWithVoice();
      }
    }
  }

  Future<Null> _registerWithVoice() async {
    String response;
    response = await _voiceRecognitionMethodChannel.invokeMethod("register voice",{"name":fullName});
    print("native is being called:$response");
    (response=="ok")? Navigator.of(context).pushNamed(VoiceLogin.routeName):"";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: exitApp,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
      child: Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CommonWidgets.spacer(gapHeight: 20.0),
            CommonWidgets.logo(),
            CommonWidgets.spacer(gapHeight: 30.0),
            Text(
              "Almost Done! Let's add your second one.",
              textAlign: TextAlign.start,
            ),
            CommonWidgets.spacer(gapHeight: 20.0),
            instructionalText("To register your voice, please allow access to your device's microphone or contact your health plan."),
            CommonWidgets.spacer(gapHeight: 30.0),
            continueButton(),
            CommonWidgets.spacer(gapHeight: 30.0),
          instructionalText("Health Plan Service 1"),
          instructionalText("Customer Service (800) 555-2222")
          ],
        ),
      ),
    ))

    );
  }

  Future<bool> exitApp() {
print("app exited");
    exit(0);
  }
}
