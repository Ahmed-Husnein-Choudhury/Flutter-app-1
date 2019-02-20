import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medicaid/main.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:medicaid/screens/biometric_camera.dart';
import 'package:medicaid/screens/voice_login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medicaid/api_and_tokens/api_info.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicaid/api_and_tokens/authentication_token.dart';

class FacialLogin extends StatefulWidget {
  // defining the route here
  static final String routeName = "/facialLogin";

  @override
  _FacialLoginState createState() => _FacialLoginState();
}

class _FacialLoginState extends State<FacialLogin> {
  @override
  initState() {
    super.initState();
    getAuthenticationToken();
  }

  Future<Null> getAuthenticationToken() async {
    SharedPreferences memberIdPref = await SharedPreferences.getInstance();
    print("stored member number:${memberIdPref.getString("member number")}");

    String url = ApiInfo.getBaseUrl() + "/oauth/token";
    var body = {
      "username": memberIdPref.getString("member number"),
      "password": "secret",
      "grant_type": "password",
      "client_id": 2,
      "client_secret": "95Vf5mPrToXQllg8XbjI5g702D5sGTPjckgU7boM",
      "provider": "members"
    };

    try {
      final response = await post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode(body));

      print("response code:${response.statusCode}");

      if (response.statusCode == 200) {
        String accessToken = json.decode(response.body)["access_token"];
        String tokenType = json.decode(response.body)["token_type"];
        AuthenticationToken.setToken(tokenType, accessToken);
      } else {
        _openDialogConnectionFailed();
      }
    }
    catch(e){
      _openDialogConnectionFailed();
    }
  }

  Future<void> initiateCamera() async {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {}
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
              ]))
        ],
      ),
    );
  }

  // defining the privacy text details text widget
  Widget bottomPrivacyTextLabel() {
    return Container(
      alignment: Alignment.bottomLeft,
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

  Widget continueButton() {
    return Container(
      height: 60.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),

        ///the function below takes camera permission and then opens the camera

        onPressed: requestCameraPermission,
        child: Text(
          "Continue",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
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

      initiateCamera();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BiometricCamera(
                    process: "Facial Login",
                  )));

      //_openCamera();

  }

  void _openDialogConnectionFailed() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Connection to Server Failed",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Divider(
                    height: 2.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      getAuthenticationToken();
                      //  _openCamera();
                    },
                    color: Color(0XFF00AFDF),
                    shape: StadiumBorder(
                      side: BorderSide(
                        width: 1.0,
                        color: Color(0XFF00AFDF),
                      ),
                    ),
                    child: Text("Please try again"),
                  )
                ],
              ),
            ),
          );
        });
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
                  ],
                ))),

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
      ]),
    ));
  }
}
