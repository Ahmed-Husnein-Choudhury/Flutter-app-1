import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:medicaid/utils/routes.dart';
import 'package:medicaid/screens/facial_setup.dart';
import 'package:medicaid/screens/home_page.dart';
import 'package:medicaid/screens/landing_page.dart';
import 'package:medicaid/screens/facial_login.dart';

List<CameraDescription> cameras;
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
      //home:FacialRecognitionSetup(healthPlanName: "Square",)
      home:LandingPage()
  ));
}
//g