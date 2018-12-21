import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:medicaid/routes.dart';
import 'package:medicaid/screens/landing_page.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';

List<CameraDescription> cameras;
bool isRegistered=false;

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
      home:VoiceRegistrationSetUp()
  ));
}
//g