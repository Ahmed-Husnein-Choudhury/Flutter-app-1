import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:medicaid/utils/screen_transition_animation.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicaid/screens/all_information_confirmed_details.dart';

class GeoLocateProvider extends StatefulWidget {
  static const String routeName = "/geoLocateProvider";
  double lat,lng;
  String providerAddress;

  GeoLocateProvider({this.lat,this.lng,this.providerAddress});
//  CheckInVerificationCodeModel receivedVerificationCode;
  @override
  _State createState() => new _State();
}

class _State extends State<GeoLocateProvider> {

 // Map<String,double> currentLocation=new Map();
  var currentLocation = <String, double>{};
  StreamSubscription<Map<String,double>> locationSubscription;
  var location=new Location();
  LocationData locationData;
  double dummyLatitude, dummyLongitude;

  @override
  void initState() {
getLocation();
  }


  Future<Map<String,double>> getCurrentLocation() async {

    print("initial location:${currentLocation["latitude"]},${currentLocation["longitude"]}");

      locationData = await location.getLocation();

    print("user location:${locationData.latitude},${locationData.longitude}");
    }


  Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.png",
        height: 100.0,
      ),
    );
  }

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

  Widget confirmButton(BuildContext context) {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> new AllInformationConfirmedDetails())
          );
        },
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
        height: MediaQuery
            .of(context)
            .size
            .height / 2.5,
        width: MediaQuery
            .of(context)
            .size
            .width / 1.1,
        child: GoogleMap(
          myLocationEnabled: true,
          trackCameraPosition: true,
          initialCameraPosition: CameraPosition(
              target:
           //   LatLng(widget.lat,widget.lng), zoom: 15.0),
              LatLng(23.781832,90.413211), zoom: 15.0),
          onMapCreated: (GoogleMapController controller) {
            controller.addMarker(
                MarkerOptions(position:
              //  LatLng(widget.lat,widget.lng)));
                LatLng(23.781832,90.413211),

  infoWindowText: InfoWindowText(widget.providerAddress, ""),
                ));

          },
        ),
      ),
    );
  }

  void getLocation() async {
    final response= await getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Column(
                    children: <Widget>[
                      logo(),
                      CommonWidgets.spacer(gapHeight: 15.0),
                      instructionalText(),
                    ],
                  )

              ),

              Positioned(
                child: Align(
                  alignment: FractionalOffset.center,
                  child:

                  showMap(context),
                ),
              ),

              Positioned(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          confirmButton(context),
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