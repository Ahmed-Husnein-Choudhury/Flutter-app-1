import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';
import 'package:medicaid/screens/biometric_camera.dart';

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
    final cameraPermission =
        await SimplePermissions.requestPermission(Permission.Camera);
    final writePermission = await SimplePermissions.requestPermission(
        Permission.WriteExternalStorage);
    if (cameraPermission == PermissionStatus.authorized &&
        writePermission == PermissionStatus.authorized) {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>BiometricCamera(process: "Facial Registration",)));

      //_openCamera();

    } else {
      // do something
    }
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
          Text(
              "Your privacy is very important to use. We protect your personal health information as required by law."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
//        isCaptured
//            ?
//        Container(
//                child: Center(
//                  child: Image.file(
//                    this.imageFile,
//                    fit: BoxFit.fitHeight,
//                    height: MediaQuery.of(context).size.height,
//                    colorBlendMode: BlendMode.darken,
//                  ),
//                ),
//              )
//            :
        SingleChildScrollView(
                child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            CommonWidgets.spacer(gapHeight: 20.0),
                            logo(),
                            CommonWidgets.spacer(gapHeight: 30.0),
                            instructionalText(),
                            CommonWidgets.spacer(gapHeight: 50.0),

                            ///This button opens the camera when tapped

                            getStartedButton(),
                            CommonWidgets.spacer(gapHeight: 30.0),
                            healthPlanLabel(),
                            CommonWidgets.spacer(gapHeight: 30.0),
                            bottomPrivacyTextLabel(),
                            CommonWidgets.spacer(gapHeight: 20.0),
                          ],
                        ),
                      )
              ));
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

  void _openCameraDialogEnrolled(int pictureNumber) {
    String successString, dialogBody, buttonText;
    bool registrationComplete = false;

    if (pictureNumber >= 1) {
      successString = "Congratulations!";
      dialogBody = "You have completed step ${3 - pictureNumber} of 3";
      buttonText = "Continue to Step ${3 - pictureNumber + 1}";
    } else {
      successString = "Congratulations!";
      dialogBody = "You have successfully registered your face";
      buttonText = "Continue";
      registrationComplete = true;
    }

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
                      successString,
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      dialogBody,
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
                        child: Text(buttonText,
                            style:
                            TextStyle(color: Colors.white, fontSize: 15.0)),
                        onPressed: !registrationComplete
                            ? () {
                          Navigator.of(context).pop();
                          setState(() {
                            this.isCaptured = false;
                            this.imageFile = null;
                          });
                          _openCamera();
                        }
                            : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VoiceRegistrationSetUp()));
                        })
                  ],
                ),
              ));
        },
      );
    } else {
      Navigator.of(context)
          .popUntil(ModalRoute.withName('/facialRecognitioSetup'));
    }
  }


  ///This function invokes the native part of the app using the ID:"register face" which matches with the one in the MainActivity.java of the
  ///android part. To access the Android activities, please open the "android" folder in the project and proceed from there

  Future<Null> _registerFace(String fileName) async {
    response = await _faceRegistrationMethodChannel
        .invokeMethod("register face", {"file path": fileName});
    print("file has been sent to native: $response");

    this.isCameraOpened = true;

    if (response) {
      print("response: $response");
      pictureNumber--;
      _openCameraDialogEnrolled(pictureNumber);
    } else {
      print("response: $response");
      _openCameraDialogFailed();
    }
  }

  void _openCameraDialogFailed() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Enrollment Failed",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Divider(
                    height: 2.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      loadingScreen();
                      Navigator.of(context).pop();
                      _openCamera();
                    },
                    color: Color(0XFF00AFDF),
                    shape: StadiumBorder(
                      side: BorderSide(
                        width: 1.0,
                        color: Color(0XFF00AFDF),
                      ),
                    ),
                    child: Text("Try Again"),
                  )
                ],
              ),
            ),
          );
        });
  }


  _openCamera() async {

    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        this.imageFile = image;
        this.isCaptured = true;

        ///this function is the bridge between flutter and native android (java)

        _registerFace(imageFile.path);

        print("Path: " + imageFile.path);
      } else {
        SystemNavigator.pop();
        //Navigator.of(context).popUntil(ModalRoute.withName('/facialRecognitioSetup'));
      }
    });
  }


}
