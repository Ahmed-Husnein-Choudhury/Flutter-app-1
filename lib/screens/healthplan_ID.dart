import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthPlanID extends StatelessWidget{

  static const String routeName="/healthplanID";

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
          RichText(text: TextSpan(style: TextStyle(fontSize: 14.0,height: 1.2),
              children: [
                TextSpan(text:"Customer Service ",style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: '(800) 555-2222',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () async {
                      String url = "tel:800555-2222";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else{
                        throw 'Could not launch $url';
                      }
                    }
                ),
              ]
          ))
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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: CustomAppBar(title: "Health Plan ID Card",),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                logo(),
                CommonWidgets.spacer(gapHeight: 20.0),
                healthPlanID(context),
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
    )
    );
  }

  Widget healthPlanID(BuildContext context) {
    return Center(
      child: Image.asset("assets/sample_healthplan_id.png",height: MediaQuery.of(context).size.height/1.75,),
    );

  }
}