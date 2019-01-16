import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';

class ReferralsAndAuthorizations extends StatefulWidget {

  static const String routeName = "/referralsAndAuthorization";

  @override
  _ReferralsAndAuthorizationsState createState() => _ReferralsAndAuthorizationsState();
}

class _ReferralsAndAuthorizationsState extends State<ReferralsAndAuthorizations> {

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
                fontSize: 15.0,
                color: Color(0XFFA9A9A9)
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              subTitle,
              style: TextStyle(
                  color: Colors.black,
                  height: 1.0,
                  fontSize: 13.0,
              ),
            )
          ],
        )
    );
  }

  Widget tilesHeading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        heading,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.0,
            fontSize: 18.0,
            color: Color(0XFF00AFDF)
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Referrals & Authorization"),
      body: Container(
        color: Color(0XFFF3F3F3),
        padding: EdgeInsets.only(left: 10.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              tilesHeading("Referrals"),
              singleInfoTile("For", "Dr. Millard, Cardiologist"),
              singleInfoTile("Address 1", "120 Wall Street #250"),
              singleInfoTile("City", "New York"),
              singleInfoTile("Zip", "10001"),
              singleInfoTile("From", "Dr. Someone Chunnu"),
              singleInfoTile("Date Referred", "1/11/2018"),
              singleInfoTile("Reason", "Heart Specialist Needed"),
              singleInfoTile("Need Help ?", "888-555-1234"),
              tilesHeading("Authorization"),
              singleInfoTile("Location", "Mount Sinai Hospital"),
              singleInfoTile("Reason", "In Patient Visit"),
              singleInfoTile("Approved Date", "July 21, 2018 - July 28, 2018"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BaseTheme(
        context: context,
        navigation: CustomBottomNavigation(context: context, index: 4),
      ),
    );
  }
}
