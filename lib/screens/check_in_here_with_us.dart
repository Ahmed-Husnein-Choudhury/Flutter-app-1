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
  static final ADDRESS = "17 East 102nd street \nNew York, NY";
  static final HOSPITAL_NAME = "Mount Sinai Internal Medicine Associates";
  static final BASED_ON_YOUR_LOCATION =
      "Based on your location \nyou are currently at";
  static final NOT_CORRECT = "Not correct?";

  String lat = "23.862675";
  String lng = "90.397026";
  String zoom = "150";



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
            child: new Column(children: <Widget>[
              new Padding(
                padding: EdgeInsets.fromLTRB(31.00, 47.00, 15.00, 0.00),
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    new Text(
                      SWIPE,
                      style:
                      TextStyle(color: Color(0XFF8785FF), fontSize: 25.00),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.00)),
                    textView(BASED_ON_YOUR_LOCATION),
                    new Padding(padding: EdgeInsets.only(top: 18.00)),
                    new Text(
                      ADDRESS,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.00),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 18.00)),
                    new Text(
                      HOSPITAL_NAME,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.00),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 18.00)),
                    new InkWell(
                      child: new Text(
                        NOT_CORRECT,
                        style: TextStyle(
                            color: Color(NotCorrectLocation.appBarTextColor),
                            fontSize: 15.00),
                      ),
                      onTap: () {
                        Navigator.push(
                            context, SlideRightRoute("Not Correct Location")
//
                        );
                      },
                    ),
                    //  new RaisedButton(onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context)=>MapTest(),));}),
//                    new RaisedButton(onPressed: () {
//                      Navigator.push(
//                          context, SlideRightRoute("Your Plan Details"));
//                    }),
                  ],
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: new InkWell(
                  child: new Center(
                    child: showMap,
                  ),
                  onTap: () {},
                ),
              ),
            ]),
          ),
        ));
  }
}
