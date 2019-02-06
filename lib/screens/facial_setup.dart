import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'dart:io';
import 'package:platform/platform.dart';
import 'package:camera/camera.dart';
import 'package:permission/permission.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';
import 'package:medicaid/screens/biometric_camera.dart';
import 'package:url_launcher/url_launcher.dart';

class FacialRecognitionSetup extends StatefulWidget {
  String healthPlanName;

  // defining the route here
  static final String routeName = "/facialRecognitionSetup";

  FacialRecognitionSetup({this.healthPlanName});

  @override
  _FacialRecognitionSetupState createState() => _FacialRecognitionSetupState();
}

const _faceRegistrationMethodChannel =
    const MethodChannel("biometric authentication");

class _FacialRecognitionSetupState extends State<FacialRecognitionSetup> {
  // image file
  File imageFile;
  bool response;
  var image;
  bool isCaptured;
  int pictureNumber = 3;
  bool isCameraOpened;
  CameraController controller;

  @override
  initState() {
    this.isCaptured = false;
    this.isCameraOpened = false;
    super.initState();
  }

  // requesting permission to access camera
  void requestCameraPermission() async {
    PermissionName cameraPermission=PermissionName.Camera;
    PermissionName storagePermission=PermissionName.Storage;
    PermissionName audioPermission=PermissionName.Microphone;
    String message="PermissionStatus.allow";
    var permission =
        await Permission.requestPermissions([cameraPermission,storagePermission,audioPermission]);

    print("permission:${permission[0].permissionStatus}");
    if(message=="${permission[0].permissionStatus}") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BiometricCamera(
                    process: "Facial Registration",
                  )));
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BiometricCamera(
                  process: "Facial Registration",
                )));
  }

  // widget for showing logo
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
    return Text(
      "In order to help protect your privacy and provide you with the best experience, we will"
          " need to set up an extra layer of security. This will include facial recognition and "
          "speech recognition. This one-time setup should take less than 30 seconds to complete.",
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
          Text(widget.healthPlanName),
          CommonWidgets.spacer(gapHeight: 5.0),
          RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 14.0, height: 1.2),
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
              ])),
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

  Widget getStartedButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),

        ///the function below takes camera permission and then opens the camera

        onPressed: requestCameraPermission,
        child: Text(
          "Let's get started",
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

  Widget loadingScreen() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/bhold_static_loading.jpg",
            height: 100.0,
            width: 100.0,
          ),
//              CircularProgressIndicator(
//                strokeWidth: 2.0,
//              ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Text(
            "Loading...",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(children: <Widget>[
      Positioned(
          child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            CommonWidgets.spacer(gapHeight: 20.0),
            logo(),
            CommonWidgets.spacer(gapHeight: 30.0),
            instructionalText(),
            CommonWidgets.spacer(gapHeight: 30.0),
            getStartedButton(),
          ],
        ),
      )),
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
                  )))),
    ])));
  }
}
