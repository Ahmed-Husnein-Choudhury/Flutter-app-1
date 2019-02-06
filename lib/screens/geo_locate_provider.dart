import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:medicaid/utils/screen_transition_animation.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocateProvider extends StatefulWidget {
  static const String routeName = "/geoLocateProvider";

//  CheckInVerificationCodeModel receivedVerificationCode;
  @override
  _State createState() => new _State();
}

class _State extends State<GeoLocateProvider> {
  @override
  void initState() {}

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
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Text(
          "Please confirm whether the provider's information below is accurate.",
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

  Widget confirmButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: null,
        child: Text(
          "Confirm",
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

  Widget notCorrectLocation(BuildContext context) {
    return new InkWell(
      child: new Text(
        "Not Correct?",
        style: TextStyle(
          color: Color(0XFF00AFDF),
          fontSize: 15.00,
        ),
      ),
      onTap: () {
        Navigator.push(context, SlideRightRoute("Not Correct Location")
//
            );
      },
    );
  }

  Widget showMap(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width / 1.1,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(23.7811619, 90.4138226), zoom: 18.0),
          onMapCreated: (GoogleMapController controller) {
            controller.addMarker(
                MarkerOptions(position: LatLng(23.7811619, 90.4138226)));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//        appBar: CustomAppBar(
//          title: "Check In",
//        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
          child: Stack(
            children: <Widget>[
              Positioned(
          child:Column(
                children: <Widget>[
                  logo(),
                  CommonWidgets.spacer(gapHeight: 15.0),
                  instructionalText(),
                ],
              )

              ),

              Positioned(
                child:Align(
                  alignment: FractionalOffset.center,
              child:showMap(context),
              ),
              ),

              Positioned(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child:
                         Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          confirmButton(),
                          CommonWidgets.spacer(gapHeight: 10.0),
                          notCorrectLocation(context),
                        ],
                      )
                  )),

//                CommonWidgets.spacer(gapHeight: 10.0),
//                healthPlanLabel(),
//                CommonWidgets.spacer(gapHeight: 10.0),
//                bottomPrivacyTextLabel(),
            ],
          ),
        ),
        bottomNavigationBar: BaseTheme(
          context: context,
          navigation: CustomBottomNavigation(context: context, index: 4),
        ));
  }
}
