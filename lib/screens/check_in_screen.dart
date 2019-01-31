import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medicaid/screens/check_in_verification_code.dart';

class CheckInScreen extends StatelessWidget {
  static const String routeName = "/checkInScreen";

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
      "Great! Please click below to continue with check in process.",
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

  Widget checkInButton(BuildContext context) {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: () {
          Navigator.of(context).pushNamed(CheckInVerificationCode.routeName);
        },
        child: Text(
          "Check In Now",
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
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(
          title: "Check In",
        ),
        body: Container(
          child: Stack(children: <Widget>[
            Positioned(
                child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  logo(),
                  CommonWidgets.spacer(gapHeight: 20.0),
                  instructionalText(),
                  CommonWidgets.spacer(gapHeight: 20.0),
                  checkInButton(context),
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
                        ))))
          ]),
        ),
        bottomNavigationBar: BaseTheme(
          context: context,
          navigation: CustomBottomNavigation(context: context, index: 4),
        ));
  }
}
