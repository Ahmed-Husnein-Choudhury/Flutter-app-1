import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:path/path.dart';

class AllInformationConfirmedDetails extends StatelessWidget {
  static const String routeName = "/allInformationConfirmedDetails";

  Widget singleInfoTile(String title, String subTitle) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                  fontSize: 18.0,
                  color: Color(0XFF6A6A6A)),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              subTitle,
              style: TextStyle(color: Colors.grey, height: 1.0, fontSize: 15.0),
            )
          ],
        ));
  }

  Widget tilesHeading(String heading, BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          heading,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.0,
            fontSize: 18.0,
            // color: Color(0XFF00AFDF)
          ),
        ));
  }

  Widget showYourDoctor(String heading, BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          heading,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              height: 1.0,
              fontSize: 18.0,
              color: Color(0XFF00AFDF)),
        ));
  }


  Widget rowStack(String columnTitle1, columnBody1, columnTitle2, columnBody2) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Text(columnTitle1), Text(columnBody1)],
            )),
        Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(columnTitle2), Text(columnBody2)],
            )),
      ],
    );
  }

  Widget padding(double pixels) {
    return Padding(padding: EdgeInsets.only(top: pixels));
  }

  Widget checkInComplete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
            child: Image.asset(
          "assets/checked.png",
          height: 100,
          width: 100,
        )),
        Text("Check-in Complete.",
        style: TextStyle(fontSize: 20.0),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Information Confirmed"),
      body: Container(
        color: Color(0XFFF3F3F3),
        padding: EdgeInsets.only(left: 10.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
          child: Column(children: <Widget>[
            checkInComplete(),
            padding(40),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(bottom: 10.0, left: 10.0)),
                rowStack(
                    "DATE",
                    DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    "VERIFIED TIME",
                    DateFormat("kk:mm:ss").format(DateTime.now())),
                padding(10),
                singleInfoTile(
                    "YOU'RE ELIGIBLE TODAY WITH", "YOUR HEALTH PLAN"),
                padding(10),
                singleInfoTile(
                    "YOU'RE COVERED AT", "Mount Sinai Internal Medicine"),
                padding(10),
                rowStack("YOUR NAME", "Ben Hoefs", "YOUR DOB", "June 22, 1970"),
                padding(10),
                tilesHeading("AUTHORIZATIONS-", context),
                padding(10),
                tilesHeading("SHOW YOUR DOCTOR", context),
                padding(10),
                Text(
                  "01",
                  style: TextStyle(
                      color: Colors.grey, height: 1.0, fontSize: 18.0),
                ),
                padding(10),
                singleInfoTile("REFERRALS", "None"),
                padding(10),
                singleInfoTile(
                    "OTHER COVERAGE", "No other health plans on file"),
              ],
            ),
          ]),
        ),
      ),
      bottomNavigationBar: BaseTheme(
        context: context,
        navigation: CustomBottomNavigation(context: context, index: 4),
      ),
    );
  }

}
