import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' as Io;

import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/utils/screen_transition_animation.dart';
import 'package:medicaid/screens/all_information_confirmed.dart';
import 'package:medicaid/screens/not_correct_location.dart';

//final API_KEY = "AIzaSyDU81YVe6jOyA4OO79DOzVN7wJ5DtD1Kn0";
final API_KEY = "AIzaSyA1G8L4q33FsJVtiKlHOq_vZefqtesCsmY";

class CheckInHere extends StatefulWidget {

  static final String routeName="/checkInHereWithUs";

  @override
  _State createState() => new _State();
}

class _State extends State<CheckInHere> {
  List<Widget> checkInForDoctorsVisitSlider = [
    Screen(),
    InformationConfirmed()
  ];


  @override
  Widget build(BuildContext context) {
    return  PageView.builder(
        itemCount: checkInForDoctorsVisitSlider.length,
        itemBuilder: (BuildContext context, int index) =>
        checkInForDoctorsVisitSlider[index],
    );
  }
}

class Screen extends StatefulWidget {
  @override
  ScreenState createState() => new ScreenState();
}

class ScreenState extends State<Screen> {
  static final SWIPE = "Swipe to continue";
  static final ADDRESS = "55th Broadway \nNew York, NY, 10006";
  static final HOSPITAL_NAME = "Mount Sinai Internal Medicine Associates";
  static final BASED_ON_YOUR_LOCATION =
      "Based on your location you are currently at";
  static final NOT_CORRECT = "Not correct?";

  String lat = "40.706782";
  String lng = "-74.012966";
  String zoom = "100";



  Future getCurrentLocation() async{
    //Position position=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("response from future");

    //print("latitude: ${position.latitude},longitude: ${[position.longitude]}");
//    lat=position.latitude as String;
//    lng=position.longitude as String;
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Widget textView(String text) {
    print("Hello");
    return new Text(text,
        style: TextStyle(fontSize: 15.00, color: Colors.black54));
  }

  @override
  Widget build(BuildContext context) {

    var showMap = new Image.network(
      // staticMapUri.toString()
        "https://maps.googleapis.com/maps/api/staticmap?center=" +
            lat +
            "%2C" +
            lng +
            "&zoom=" +
            zoom +
            "&scale=2&size=1000x700&maptype=roadmap"
                "&" +
            "key=" +
            API_KEY);

    return Scaffold(
        appBar: CustomAppBar(title: "Check in for Doctor's Visit"),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Container(
            color: Color(0XFFF3F3F3),
            child: new Column(children: <Widget>[
              new Padding(
                padding: EdgeInsets.fromLTRB(10.00, 50.00, 15.00, 0.00),
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    new Text(
                      SWIPE,
                      style:
                      TextStyle(color:  Color(0XFF00AFDF), fontSize: 23.00),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.00)),
                    textView(BASED_ON_YOUR_LOCATION),
                    new Padding(padding: EdgeInsets.only(top: 18.00)),
                    new Text(
                      ADDRESS,
                      style: TextStyle(
                        fontSize: 16.00,
                        color: Color(0XFF6A6A6A),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 18.00)),
                    new Text(
                      HOSPITAL_NAME,
                        style: TextStyle(
                            fontSize: 16.00,
                            color: Color(0XFF6A6A6A),
                            fontWeight: FontWeight.bold
                        )
                    ),
                    new Padding(padding: EdgeInsets.only(top: 18.00)),
                    new InkWell(
                      child: new Text(
                        NOT_CORRECT,
                        style: TextStyle(
                            color:  Color(0XFF00AFDF),
                            fontSize: 15.00,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context, SlideRightRoute("Not Correct Location")
//
                        );
                      },
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: new InkWell(
                  child: new Center(
                    child:
                    showMap,
                  ),
                  onTap: () {},
                ),
              ),
            ]),
          ),
        ));
  }
}
