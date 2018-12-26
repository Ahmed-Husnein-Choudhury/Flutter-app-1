import 'package:flutter/material.dart';

import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/screens/claim_and_appointments.dart';
import 'package:medicaid/screens/upcoming_appointments.dart';
import 'package:medicaid/screens/referrals_and_authorizations.dart';
import 'package:medicaid/screens/your_plan_details.dart';
import 'package:medicaid/screens/check_in_here_with_us.dart';

class HomePage extends StatefulWidget {
  // defining the route
  static const String routeName = "/homePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static final oddColumnTextColor = 0XFFFB06EF8;
  static final evenColumnTextColor = 0XFF919EFA;
  static final oddColumnBackGroundColor = 0XFFF8F9FF;
  static final evenColumnBackGroundColor = 0XFFECECFE;
  static final activeRouteLinkColor = 0XFFB4BDFB;

  Widget menuOption({@required String optionTitle, @required bool isOdd,@required VoidCallback onTap }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(0.0),
        child: Container(
            height: 120.0,
            padding: EdgeInsets.all(25.0),
            color: Color(isOdd ? oddColumnBackGroundColor : evenColumnBackGroundColor),
            child: Center(
              child: Text(
                optionTitle,
                style: TextStyle(
                    color: Color(isOdd ? oddColumnTextColor : evenColumnTextColor),
                    fontSize: 14.0
                ),
                textAlign: TextAlign.center,
              ),
            )
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      bottomNavigationBar: CustomBottomNavigation(context: context, index: 0),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              menuOption(
                optionTitle: "At your doctor's office?\nCheck in here with us first",
                isOdd: true,
                onTap: (){
                  Navigator.of(context).pushNamed(CheckInHere.routeName);
                }
              ),
              menuOption(
                  optionTitle: "Your Plan Details",
                  isOdd: false,
                  onTap: () {
                    Navigator.of(context).pushNamed(YourPlanDetails.routeName);
                  }
              ),
              menuOption(
                  optionTitle: "Claims and Past Appointments",
                  isOdd: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(ClaimsAndAppointments.routeName);
                  }
              ),
              menuOption(
                  optionTitle: "Upcoming Appointments",
                  isOdd: false,
                  onTap: () {
                    Navigator.of(context).pushNamed(UpcomingAppointments.routeName);
                  }
              ),
              menuOption(
                  optionTitle: "Referrals and Authorization",
                  isOdd: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(ReferalsAndAuthrizations.routeName);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}