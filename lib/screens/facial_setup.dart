import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:simple_permissions/simple_permissions.dart';

class FacialRecognitionSetup extends StatefulWidget {

  // defining the route here
  static final String routeName = "/facialRecognitioSetup";

  @override
  _FacialRecognitionSetupState createState() => _FacialRecognitionSetupState();
}

class _FacialRecognitionSetupState extends State<FacialRecognitionSetup> {

  // image file
  File imageFile;
  bool isCaptured;

  @override
  initState() {
    this.isCaptured = false;
    super.initState();
  }

  void _reOpenCameraDialog() {
    if (this.imageFile != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Success!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Divider(
                      height: 2.0,
                    )
                  ],
                ),
              ),
              content: Container(
                height: 180.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Great, the first picture was successful. Only 2 more pictures left to take!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    CommonWidgets.spacer(gapHeight: 25.0),
                    RaisedButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            this.isCaptured = false;
                            this.imageFile = null;
                          });
                          _openCamera();
                        }
                    )
                  ],
                ),
              )
          );
        },
      );
    } else {
      Navigator.of(context).popUntil(ModalRoute.withName('/facialRecognitioSetup'));
    }

  }

  _openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        this.imageFile = image;
        this.isCaptured = true;
        _reOpenCameraDialog();
        print("Path: "+imageFile.path);
      } else {
        SystemNavigator.pop();
        //Navigator.of(context).popUntil(ModalRoute.withName('/facialRecognitioSetup'));
      }
    });
  }

  // requesting permission to access camera
  void requestCameraPermission() async {
    final cameraPermission = await SimplePermissions.requestPermission(Permission.Camera);
    final writePermission = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    if (cameraPermission == PermissionStatus.authorized && writePermission == PermissionStatus.authorized) {
      _openCamera();
    } else {
      // do something
    }
  }

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
      "Let's get started. Setting up extra authentication is required for you to receive the best experience with this"
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
      onPressed: requestCameraPermission,
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
        body: isCaptured ? Container(
          child: Center(
            child: Image.file(this.imageFile, fit: BoxFit.fitHeight, height: MediaQuery.of(context).size.height, colorBlendMode: BlendMode.darken,),
          ),
        ) : SingleChildScrollView(
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
        )
    );
  }
}
