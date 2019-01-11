import 'package:flutter/material.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:medicaid/screens/biometric_camera.dart';
import 'package:medicaid/screens/voice_login.dart';

class FacialLogin extends StatefulWidget {

  // defining the route here
  static final String routeName = "/facialLogin";

  @override
  _FacialLoginState createState() => _FacialLoginState();
}

class _FacialLoginState extends State<FacialLogin> {

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
      "Great! Let's get started by verifying your identity using the biometrics you set up when you registered your account.",
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

  Widget continueButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),

        ///the function below takes camera permission and then opens the camera

        onPressed: requestCameraPermission,
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


  void requestCameraPermission() async {
    final cameraPermission =
    await SimplePermissions.requestPermission(Permission.Camera);
    final writePermission = await SimplePermissions.requestPermission(
        Permission.WriteExternalStorage);
    if (cameraPermission == PermissionStatus.authorized &&
        writePermission == PermissionStatus.authorized) {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>BiometricCamera(process: "Facial Login",)));

      //_openCamera();

    } else {
      // do something
    }
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
                continueButton(),
                CommonWidgets.spacer(gapHeight: 30.0),
                healthPlanLabel(),
                CommonWidgets.spacer(gapHeight: 50.0),
                bottomPrivacyTextLabel(),
                CommonWidgets.spacer(gapHeight: 20.0),
              ],
            ),
          ),
        ));
  }

}
