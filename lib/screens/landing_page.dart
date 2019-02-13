import 'package:flutter/material.dart';
import 'package:medicaid/screens/geo_locate_provider.dart';
import 'package:medicaid/screens/medical_emergency_screen.dart';
import 'package:medicaid/screens/voice_login.dart';
import 'package:permission/permission.dart';
import 'package:medicaid/screens/member_registration.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';
import 'package:medicaid/screens/facial_login.dart';
import 'dart:io';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_settings/app_settings.dart';

class LandingPage extends StatefulWidget {
  // defining the route here
  static final routeName = "/landingPage";

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // defining the login button widget
  bool isRegistered = false;
  double lat,lng;

  Map<String,dynamic> data;

  String fcmTopic;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void fcmSubscribe() {
    print("subscription topic:$fcmTopic");
    _firebaseMessaging.subscribeToTopic("200200200");
  }

  void fcmUnSubscribe() {
    _firebaseMessaging.subscribeToTopic(fcmTopic);
  }

  @override
  void initState() {
    super.initState();
    checkIfRegisteredAndAddFcmTopic();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    fcmSubscribe();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message'); //called when app is active
       // data=json.decode(message.toString());
      //  String data=message["data"];
//        lat= data["lat"];
//        lng=  data["lng"];
//        print("location info:$lat,$lng");
        startMap(context,message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        //data=json.decode(message.toString());
//        lat=  message["lat"];
//        lng=  message["lng"];
//        print("location info:$lat,$lng");
        startMap(context,message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        startMap(context,message);
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void checkIfRegisteredAndAddFcmTopic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("is registered") != null &&
        prefs.getBool("is registered") != false) {
      isRegistered = true;
    }

    if (prefs.getString("member number") != null) {
      fcmTopic = prefs.getString("member number");
      firebaseCloudMessaging_Listeners();
    }

    print("stored member number:${prefs.getString("member number")}");
  }

  Widget loginButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: () => isRegistered
            ? Navigator.of(context).pushNamed(MedicalEmergency.routeName)
            : showErrorDialog("You have not registered yet.",
                "Please register before logging in."),
        // startMap(),
        child: Text(
          "Log In",
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

  // defining the register button widget
  Widget registerButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF1EE3B7),
        onPressed: () => !isRegistered
            ? Navigator.of(context).pushNamed(MemberRegistration.routeName)
            : showErrorDialog("You have already registered", "Please login"),
        //  Navigator.of(context).pushNamed(VoiceRegistrationSetUp.routeName),
        child: Text(
          "Register",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        shape: StadiumBorder(
          side: BorderSide(
            width: 1.0,
            color: Color(0XFF1EE3B7),
          ),
        ),
      ),
    );
  }

  Widget titleText() {
    return Column(
      children: <Widget>[
        Text(
          "Welcome!",
          style: TextStyle(
            color: Color(0XFF00AFDF),
            fontSize: 34.0,
          ),
        ),
      ],
    );
  }

  Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.png",
        height: 100.0,
      ),
    );
  }

  Future<Null> startMap(BuildContext context,Map<String,dynamic> message) async {
     data=new Map<String,dynamic>.from(message["data"]);
//    String latd=data["lat"];
//     String lngd=data["lng"];
    lat=double.parse(data["lat"]);
    lng=double.parse(data["lng"]);
     print("location info:$lat,$lng");
    print("location info:$data");

    String pMessage = "PermissionStatus.allow";
    var locationPermission =
        await Permission.requestPermissions([PermissionName.Location]);
    if (pMessage == "${locationPermission[0].permissionStatus}") {

    //  AppSettings.openLocationSettings();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>GeoLocateProvider(lat: lat,lng: lng,)));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40.0),
        ),
        logo(),
        CommonWidgets.spacer(gapHeight: MediaQuery.of(context).size.height / 7),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                titleText(),
                CommonWidgets.spacer(gapHeight: 30.0),
                loginButton(),
                CommonWidgets.spacer(gapHeight: 15.0),
                Text(
                  "Log in to continue.",
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
                CommonWidgets.spacer(gapHeight: 25.0),
                registerButton(),
                CommonWidgets.spacer(gapHeight: 15.0),
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
                Text(
                  "Register now for access",
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
                CommonWidgets.spacer(gapHeight: 20.0),
              ],
            ),
          ),
        ]),
      ],
    )));
  }

  void showErrorDialog(String title, String body) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.0),
                  ),
                  Divider(
                    height: 2.0,
                  )
                ],
              ),
            ),
            content: Container(
              height: 100.0,
              child: Column(
                children: <Widget>[
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
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
                      child: Text("OK",
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.0)),
                      onPressed: () => Navigator.of(context).pop())
                ],
              ),
            ));
      },
    );
  }
}
