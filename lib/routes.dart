import 'package:flutter/material.dart';
import 'package:medicaid/screens/landing_page.dart';
import 'package:medicaid/screens/member_registration.dart';
import 'package:medicaid/screens/member_verification.dart';
import 'package:medicaid/screens/member_information.dart';
import 'package:medicaid/screens/voice_login.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';
import 'package:medicaid/screens/facial_setup.dart';
import 'package:medicaid/screens/biometric_login.dart';
import 'package:medicaid/screens/messages.dart';
import 'package:medicaid/screens/search.dart';
import 'package:medicaid/screens/contact.dart';
import 'package:medicaid/screens/home_page.dart';
import 'package:medicaid/screens/claim_and_appointments.dart';
import 'package:medicaid/screens/claim_and_appointments_details.dart';
import 'package:medicaid/screens/upcoming_appointments.dart';
import 'package:medicaid/screens/upcoming_appointments_details.dart';
import 'package:medicaid/screens/referrals_and_authorizations.dart';
import 'package:medicaid/screens/your_plan_details.dart';
import 'package:medicaid/screens/check_in_here_with_us.dart';
import 'package:medicaid/screens/all_information_confirmed.dart';
import 'package:medicaid/screens/not_correct_location.dart';

class Routes {

  // defining all the routes through out the app
  static final routeList = <String, WidgetBuilder> {
    LandingPage.routeName: (context) => LandingPage(),
    MemberRegistration.routeName: (context) => MemberRegistration(),
    MemberVerification.routeName: (context) => MemberVerification(),
    MemberInformation.routeName: (context) => MemberInformation(),
    VoiceRegistrationSetUp.routeName: (context) => VoiceRegistrationSetUp(),
    VoiceLogin.routeName: (context) => VoiceLogin(),
    FacialRecognitionSetup.routeName: (context) => FacialRecognitionSetup(),
    BiometricLogin.routeName: (context) => BiometricLogin(),
    Messages.routeName: (context) => Messages(),
    Search.routeName: (context) => Search(),
    Contact.routeName: (context) => Contact(),
    HomePage.routeName: (context) => HomePage(),
    ClaimsAndAppointments.routeName: (context) => ClaimsAndAppointments(),
    ClaimAndAppointmentsDetails.routeName: (context) => ClaimAndAppointmentsDetails(),
    UpcomingAppointments.routeName: (context) => UpcomingAppointments(),
    UpcomingAppointMentsDetails.routeName: (context) => UpcomingAppointMentsDetails(),
    ReferalsAndAuthrizations.routeName: (context) => ReferalsAndAuthrizations(),
    YourPlanDetails.routeName: (context) => YourPlanDetails(),
    CheckInHere.routeName: (context)=> CheckInHere(),
    InformationConfirmed.routeName: (context) => InformationConfirmed(),
    NotCorrectLocation.routeName: (context) => NotCorrectLocation()
  };
}