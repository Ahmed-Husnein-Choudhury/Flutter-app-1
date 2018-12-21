import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:medicaid/screens/member_registration.dart';

class VoiceLogin extends StatefulWidget {

  static final String routeName="/voiceLogin";

  @override
  _State createState() => _State();
}

const _voiceLoginMethodChannel = const MethodChannel("biometric authentication");

class _State extends State<VoiceLogin> {

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
      Padding(
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
        _loginWithVoice();
      }
    }
  }

  Future<Null> _registerWithVoice() async {
//    String response;
//    response = await _voiceRecognitionMethodChannel.invokeMethod("record audio");
//    // String name=_MemberRegistrationState.getFirstName();
//    print("native is being called:$response");
//    (response=="ok")? Navigator.of(context).pushNamed(routeName):"";
  }

  _loginWithVoice() async {
    String response;
        response=await _voiceLoginMethodChannel.invokeMethod("login using voice");
        print("voice recognition login invoked");

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
                instructionalText("Great! We were able to verify the first biometric. "
                    "Please click continue to move to the next verification step."),
                CommonWidgets.spacer(gapHeight: 30.0),
                continueButton(),
//            RaisedButton(
//                onPressed: () => SimplePermissions.openSettings(),
//                child: Text("set permissions")),
                CommonWidgets.spacer(gapHeight: 20.0),
                instructionalText("Health Plan Service 1 \n"
                    "Customer Service (800) 555-2222"),
                CommonWidgets.spacer(gapHeight: 50.0),
                instructionalText("Your privacy is very important to use. "
                    "We protect your personal health information as required by law"),
              ],
            ),
          ),
        ));

  }
}
