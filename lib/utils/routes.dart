import 'package:flutter/material.dart';
import 'package:medicaid/screens/landing_page.dart';
import 'package:medicaid/screens/member_registration.dart';
import 'package:medicaid/screens/member_verification.dart';
import 'package:medicaid/screens/registering_member_information.dart';
import 'package:medicaid/screens/voice_login.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';
import 'package:medicaid/screens/facial_setup.dart';
import 'package:medicaid/screens/facial_login.dart';
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
import 'package:medicaid/screens/biometric_camera.dart';
import 'package:medicaid/screens/healthplan_ID.dart';
import 'package:medicaid/screens/view_member_information.dart';
import 'package:medicaid/screens/medical_emergency_screen.dart';
import 'package:medicaid/screens/check_in_screen.dart';
import 'package:medicaid/screens/check_in_verification_code.dart';

class Routes {

  // defining all the routes through out the app
  static final routeList = <String, WidgetBuilder> {
    LandingPage.routeName: (context) => LandingPage(),
    MedicalEmergency.routeName: (context) => MedicalEmergency(),
    MemberRegistration.routeName: (context) => MemberRegistration(),
    MemberVerification.routeName: (context) => MemberVerification(),
    RegisteringMemberInformation.routeName: (context) => RegisteringMemberInformation(),
    ViewMemberInformation.routeName: (context) => ViewMemberInformation(),
    VoiceRegistrationSetUp.routeName: (context) => VoiceRegistrationSetUp(),
    VoiceLogin.routeName: (context) => VoiceLogin(),
    FacialRecognitionSetup.routeName: (context) => FacialRecognitionSetup(),
    FacialLogin.routeName: (context) => FacialLogin(),
    Messages.routeName: (context) => Messages(),
    Search.routeName: (context) => Search(),
    Contact.routeName: (context) => Contact(),
    HomePage.routeName: (context) => HomePage(),
    ClaimsAndAppointments.routeName: (context) => ClaimsAndAppointments(),
    ClaimAndAppointmentsDetails.routeName: (context) => ClaimAndAppointmentsDetails(),
    UpcomingAppointments.routeName: (context) => UpcomingAppointments(),
    UpcomingAppointMentsDetails.routeName: (context) => UpcomingAppointMentsDetails(),
    ReferralsAndAuthorizations.routeName: (context) => ReferralsAndAuthorizations(),
    YourPlanDetails.routeName: (context) => YourPlanDetails(),
    CheckInHere.routeName: (context)=> CheckInHere(),
    InformationConfirmed.routeName: (context) => InformationConfirmed(),
    NotCorrectLocation.routeName: (context) => NotCorrectLocation(),
    BiometricCamera.routeName: (context) => BiometricCamera(),
    HealthPlanID.routeName: (context) => HealthPlanID(),
    CheckInScreen.routeName: (context) => CheckInScreen(),
    CheckInVerificationCode.routeName: (context) => CheckInVerificationCode(),
  };
}