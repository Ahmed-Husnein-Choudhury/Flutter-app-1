import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:medicaid/screens/all_information_confirmed_details.dart';
import 'package:medicaid/utils/routes.dart';
import 'package:medicaid/screens/facial_setup.dart';
import 'package:medicaid/screens/home_page.dart';
import 'package:medicaid/screens/landing_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:medicaid/screens/geo_locate_provider.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';
import 'package:medicaid/screens/facial_login.dart';

List<CameraDescription> cameras;
FirebaseAnalytics analytics=new FirebaseAnalytics();
 // Fetch the available cameras before initializing the app.
Future<void> main() async {

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
  }
  runApp(MaterialApp(
      title: "B.Hold",
      debugShowCheckedModeBanner: false,
      routes: Routes.routeList,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      //home:FacialRecognitionSetup(healthPlanName: "Square",)
      home:LandingPage()
  ));
}
//g