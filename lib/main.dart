import 'package:flutter/material.dart';
import 'package:medicaid/routes.dart';
import 'package:medicaid/screens/landing_page.dart';
import 'screens/voice_registration_set_up.dart';

void main() {
  runApp(MaterialApp(
      title: "B.Hold",
      debugShowCheckedModeBanner: false,
      routes: Routes.routeList,
      home: LandingPage()
  ));
}
//g