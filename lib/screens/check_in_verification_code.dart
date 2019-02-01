import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medicaid/screens/geo_locate_provider.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicaid/api_and_tokens/api_info.dart';
import 'package:medicaid/api_and_tokens/authentication_token.dart';
import 'package:medicaid/models/check_in_verification_code_model.dart';

class CheckInVerificationCode extends StatefulWidget {
  static const String routeName = "/checkInVerificationCode";

  @override
  _State createState() => new _State();
}

class _State extends State<CheckInVerificationCode>{

  String fcmTopic;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  CheckInVerificationCodeModel receivedVerificationCode;


  @override
  void initState() {
addFcmTopic();
  }

  void addFcmTopic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("member number")!=null) {
      fcmTopic=prefs.getString("member number");
      firebaseCloudMessaging_Listeners();
    }

    print("stored member number:${prefs.getString("member number")}");
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print(token);
    });

    fcmSubscribe();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');//called when app is active
        Navigator.pushNamed(context, GeoLocateProvider.routeName);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        Navigator.pushNamed(context, GeoLocateProvider.routeName);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        Navigator.pushNamed(context, GeoLocateProvider.routeName);
      },
    );
  }

  void fcmSubscribe() {
    print("subscription topic:$fcmTopic");
    _firebaseMessaging.subscribeToTopic(fcmTopic);
  }

  void fcmUnSubscribe() {
    _firebaseMessaging.subscribeToTopic(fcmTopic);
  }


  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

  Future<CheckInVerificationCodeModel> getVerificationCode() async {
    String url = ApiInfo.getBaseUrl();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String memberId = pref.getString("member number");
    final response = await get(
      url + "/api/v1/members/get_check_in_verification_code/$memberId",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": AuthenticationToken.getToken()
      },
    );
    print("response from member verification code api:${response.body}");
    //receivedVerificationCode=response.body;
    receivedVerificationCode =
        CheckInVerificationCodeModel.fromJson(json.decode(response.body));
    return receivedVerificationCode;
  }

//  Future<dynamic> startTimer(BuildContext context){
//  return new Future.delayed(
//  const Duration(seconds: 3),
//  startMap(context));
//
//  }

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
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: Text(
          "Please show this page to the provider's office staff.",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ));
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

  Widget skipButton(BuildContext context) {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed:
        (){startMap(context);},
        child: Text(
          "Skip this step",
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

  Widget progressIndicator() {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image(image: AssetImage("assets/loading_animation_03.gif")),
        ),
      ),
    );
  }

  Widget generateQRCode() {
    return QrImage(
        data: receivedVerificationCode.verificationCode, size: 200.0);
  }

  Widget unableToAcceptCode() {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: Text(
          "Is your provider unable to accept verification code?",
          style: TextStyle(fontSize: 16.0),
        ));
  }

  Widget showVerificationCode() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text("Verification Code:",
          style: TextStyle(fontSize: 16.0),),
        ),
        CommonWidgets.spacer(gapHeight: 5.0),
        Align(
          alignment: Alignment.center,
          child: Text(receivedVerificationCode.verificationCode,
              style: TextStyle(fontSize: 30.0,color: Colors.blueGrey)),
        ),
      ],
    );
  }

  Widget showVerificationScreen(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Check In",
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,20.0),
            child: Column(
              children: <Widget>[
                logo(),
                CommonWidgets.spacer(gapHeight: 20.0),
                instructionalText(),
                CommonWidgets.spacer(gapHeight: 20.0),
                generateQRCode(),
                CommonWidgets.spacer(gapHeight: 10.0),
                showVerificationCode(),
                CommonWidgets.spacer(gapHeight: 30.0),
                unableToAcceptCode(),
                CommonWidgets.spacer(gapHeight: 20.0),
                skipButton(context),
                CommonWidgets.spacer(gapHeight: 20.0),
                healthPlanLabel(),
                CommonWidgets.spacer(gapHeight: 20.0),
                bottomPrivacyTextLabel(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BaseTheme(
          context: context,
          navigation: CustomBottomNavigation(context: context, index: 4),
        ));
  }

  Future <Null> startMap(BuildContext context) async {
    final courseLocationPermission=await SimplePermissions.requestPermission(Permission.AccessCoarseLocation);
    final fineLocationPermission=await SimplePermissions.requestPermission(Permission.AccessFineLocation);

    if(courseLocationPermission==PermissionStatus.authorized && fineLocationPermission== PermissionStatus.authorized) {
      Navigator.of(context).pushNamed(GeoLocateProvider.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return FutureBuilder(
      future: getVerificationCode(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (receivedVerificationCode != null) {
            return showVerificationScreen(context);
          }
        } else
          return progressIndicator();
      },
    );
  }


}
