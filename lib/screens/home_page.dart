import 'package:flutter/material.dart';

import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/screens/claim_and_appointments.dart';
import 'package:medicaid/screens/upcoming_appointments.dart';
import 'package:medicaid/screens/referrals_and_authorizations.dart';
import 'package:medicaid/screens/your_plan_details.dart';
import 'package:medicaid/screens/check_in_here_with_us.dart';
import 'package:medicaid/screens/healthplan_ID.dart';

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

  Widget menuOption({@required String optionTitle, @required bool isOdd,@required VoidCallback onTap }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
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
            )
        ),
      ),
    );
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
                optionTitle: "At your doctor's office?\nCheck in here with us first",
                isOdd: true,
                onTap: (){
                  Navigator.of(context).pushNamed(CheckInHere.routeName);
                }
              ),
              
              menuOption(optionTitle: "View your <healthplan> ID card",
                  isOdd: true,
                  onTap: (){
                Navigator.of(context).pushNamed(HealthPlanID.routeName);
                  }
              ),
              menuOption(
                  optionTitle: "Your Plan Details",
                  isOdd: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(YourPlanDetails.routeName);
                  }
              ),
              menuOption(
                  optionTitle: "Claims and Past Appointments",
                  isOdd: false,
                  onTap: () {
                    Navigator.of(context).pushNamed(ClaimsAndAppointments.routeName);
                  }
              ),
              menuOption(
                  optionTitle: "Upcoming Appointments",
                  isOdd: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(UpcomingAppointments.routeName);
                  }
              ),
              menuOption(
                  optionTitle: "Referrals and Authorization",
                  isOdd: false,
                  onTap: () {
                    Navigator.of(context).pushNamed(ReferralsAndAuthorizations.routeName);
                  }
              ),
              SizedBox(
                height:20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}