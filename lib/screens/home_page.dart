import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicaid/screens/view_member_information.dart';

import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/screens/claim_and_appointments.dart';
import 'package:medicaid/screens/upcoming_appointments.dart';
import 'package:medicaid/screens/referrals_and_authorizations.dart';
import 'package:medicaid/screens/your_plan_details.dart';
import 'package:medicaid/screens/check_in_here_with_us.dart';
import 'package:medicaid/screens/healthplan_ID.dart';
import 'package:medicaid/screens/registering_member_information.dart';
import 'package:medicaid/api_and_tokens/api_info.dart';
import 'package:medicaid/api_and_tokens/authentication_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  // defining the route
  static const String routeName = "/homePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*static final oddColumnTextColor = 0XFFFB06EF8;
  static final evenColumnTextColor = 0XFF919EFA;
  static final oddColumnBackGroundColor = 0XFFF8F9FF;
  static final evenColumnBackGroundColor = 0XFFECECFE;*/
  static final activeRouteLinkColor = 0XFFB4BDFB;

  Widget menuOption({@required String optionTitle,
    @required bool isOdd,
    @required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
        child: Container(
            height: 100.0,
            padding: EdgeInsets.all(25.0),
            child: Center(
              child: Text(
                optionTitle,
                style: TextStyle(
                  //  color: Color(0XFF6A6A6A),
                  color: Color(0XFF00AFDF),
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }

  Future<Null> getMemberInformation() async {
    SharedPreferences MemberIdPref = await SharedPreferences.getInstance();
    String url = ApiInfo.getBaseUrl();
    final response = await get(
      url + "/api/v1/members/${MemberIdPref.getString("member number")}",
      headers: {"Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": AuthenticationToken.getToken()
      },
    );

    print("response from member information api:${response.body}");
    print("authentication token:${AuthenticationToken.getToken()}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      bottomNavigationBar: BaseTheme(
        context: context,
        navigation: CustomBottomNavigation(context: context, index: 0),
      ),
      body: Container(
        color: Color(0XFFF3F3F3),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              menuOption(
                  optionTitle:
                  "At your doctor's office?\nCheck in here with us first",
                  isOdd: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(CheckInHere.routeName);
                  }),
              menuOption(
                  optionTitle: "View your <healthplan> ID card",
                  isOdd: false,
                  onTap: () {
                    Navigator.of(context).pushNamed(HealthPlanID.routeName);
                  }),
              menuOption(
                  optionTitle: "View Your Member Information",
                  isOdd: true,
                  onTap: () {
                   // getMemberInformation();

                    Navigator.of(context)
                        .pushNamed(ViewMemberInformation.routeName);
                  }),
              menuOption(
                  optionTitle: "Your Plan Details",
                  isOdd: false,
                  onTap: () {
                    Navigator.of(context).pushNamed(YourPlanDetails.routeName);
                  }),
              menuOption(
                  optionTitle: "Claims and Past Appointments",
                  isOdd: true,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ClaimsAndAppointments.routeName);
                  }),
              menuOption(
                  optionTitle: "Upcoming Appointments",
                  isOdd: false,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(UpcomingAppointments.routeName);
                  }),
              menuOption(
                  optionTitle: "Referrals and Authorization",
                  isOdd: true,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ReferralsAndAuthorizations.routeName);
                  }),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
