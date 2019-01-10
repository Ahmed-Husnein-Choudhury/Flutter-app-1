
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicaid/main.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:path_provider/path_provider.dart';


class BiometricCamera extends StatefulWidget{
  @override
  _CameraState createState()=>_CameraState();

  static final String routeName = "/biometricCamera";
}


IconData getCameraLensIcon(CameraLensDirection direction) {
      return Icons.camera_front;
  }

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

const _faceRegistrationMethodChannel =
const MethodChannel("biometric authentication");


class _CameraState extends State<BiometricCamera>{

  File imageFile;
  bool response;
  var image;
  bool isCaptured;
  int pictureNumber = 3;
  bool isCameraOpened;

  CameraController controller;
  String imagePath;

  @override
  void initState() {
    super.initState();

    frontCameraSelected(cameras[1]);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Facial Registration'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
          _captureControlRowWidget(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
               // RaisedButton(onPressed: _cameraTogglesRowWidget,child: Text("Open camera"),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }


  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
              controller.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }


  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }



  void frontCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      print("controller disposing");
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    print("controller initialized");

    // If the controller is updated then update the UI.
    controller.addListener(() {
      print("listener in action");
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        print("controller Exception");

        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print("controller Exception");
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) showInSnackBar('Picture saved to $filePath');
        
        _registerFace(imagePath);
      }
    });
  }


  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  ///This function invokes the native part of the app using the ID:"register face" which matches with the one in the MainActivity.java of the
  ///android part

  Future<Null> _registerFace(String fileName) async {
    response = await _faceRegistrationMethodChannel
        .invokeMethod("register face", {"file path": fileName});
    print("file has been sent to native: $response");
//
//    this.isCameraOpened = true;
//
//    if (response) {
//      print("response: $response");
//      pictureNumber--;
//      _openCameraDialogEnrolled(pictureNumber);
//    } else {
//      print("response: $response");
//      _openCameraDialogFailed();
//    }
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
                        //  _openCamera();
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
                            //_openCamera();
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
  }

