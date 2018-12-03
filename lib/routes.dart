import 'package:flutter/material.dart';
import 'package:medicaid/screens/landing_page.dart';
/*
import 'package:behold/screens/upcoming_appointments.dart';
import 'package:behold/screens/search.dart';
import 'package:behold/screens/upcoming_appointments_details.dart';
import 'package:behold/screens/claim_and_appointments_details.dart';
import 'package:behold/screens/messages.dart';
import 'package:behold/screens/referrals_and_authorizations.dart';
import 'package:behold/screens/home_page.dart';
import 'package:behold/screens/contact.dart';
import 'package:behold/screens/your_plan_details.dart';*/

class Routes {

  // defining all the routes through out the app
  static final routeList = <String, WidgetBuilder> {
    LandingPage.routeName: (context) => LandingPage(),
    /*Search.routeName: (context) => Search(),
    Contact.routeName: (context) => Contact(),
    HomePage.routeName: (context) => HomePage(),
    ClaimsAndAppointments.routeName: (context) => ClaimsAndAppointments(),
    ClaimAndAppointmentsDetails.routeName: (context) => ClaimAndAppointmentsDetails(),
    UpcomingAppointments.routeName: (context) => UpcomingAppointments(),
    UpcomingAppointMentsDetails.routeName: (context) => UpcomingAppointMentsDetails(),
    ReferalsAndAuthrizations.routeName: (context) => ReferalsAndAuthrizations(),
    YourPlanDetails.routeName: (context) => YourPlanDetails(),*/
  };
}