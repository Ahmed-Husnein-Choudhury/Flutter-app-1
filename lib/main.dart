import 'package:flutter/material.dart';
import 'package:medicaid/routes.dart';
import 'package:medicaid/screens/landing_page.dart';
import 'package:medicaid/screens/biometric_login.dart';

void main() {
  runApp(MaterialApp(
      title: "B.Hold",
      debugShowCheckedModeBanner: false,
      routes: Routes.routeList,
      home: BiometricLogin()
  ));
}
//g