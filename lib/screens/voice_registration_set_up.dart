import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicaid/common_widgets.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:medicaid/screens/member_registration.dart';
import 'voice_login.dart';

class VoiceRegistrationSetUp extends StatefulWidget {

  static final String routeName="/voiceRegistrationSetup";

  @override
  _State createState() => _State();
}

const _voiceRecognitionMethodChannel = const MethodChannel("audio");

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
    return
      Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
          child:Material(
              borderRadius: BorderRadius.circular(20.0),
              shadowColor:Color(0XFF00AFDF),
              child:MaterialButton(
                onPressed: requestPermission,
                height: 40.0,
                padding: EdgeInsets.all(15.0),
                minWidth: 200.0,
                color: Color(0XFF00AFDF),
                textColor: Colors.white,
                //shape:new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(60.0)),
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                //shape: Border.all(width: 3.0),
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
    // String name=_MemberRegistrationState.getFirstName();
    print("native is being called:$response");
    (response=="ok")? Navigator.of(context).pushNamed(VoiceLogin.routeName):"";
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
           instructionalText("Almost Done! Let's add your second one."),
            CommonWidgets.spacer(gapHeight: 20.0),
            instructionalText("Please allow access  to your device's microphone or contact your health plan."),
            CommonWidgets.spacer(gapHeight: 30.0),
            continueButton(),
//            RaisedButton(
//                onPressed: () => SimplePermissions.openSettings(),
//                child: Text("set permissions")),
            CommonWidgets.spacer(gapHeight: 30.0),
          instructionalText("Health Plan Service 1 \n Customer Service (800) 555-2222")
          ],
        ),
      ),
    ));
    ;
  }
}
