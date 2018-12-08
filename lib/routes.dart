import 'package:flutter/material.dart';
import 'package:medicaid/screens/landing_page.dart';
import 'package:medicaid/screens/member_registration.dart';
import 'package:medicaid/screens/member_verification.dart';
import 'package:medicaid/screens/member_information.dart';


class Routes {

  // defining all the routes through out the app
  static final routeList = <String, WidgetBuilder> {
    LandingPage.routeName: (context) => LandingPage(),
    MemberRegistration.routeName: (context) => MemberRegistration(),
    MemberVerification.routeName: (context) => MemberVerification(),
    MemberInformation.routeName: (context) => MemberInformation(),
  };
}