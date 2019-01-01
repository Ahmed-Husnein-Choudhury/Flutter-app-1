import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';

class UpcomingAppointMentsDetails extends StatefulWidget {

  static const String routeName = "/upcomingAppointMentDetails";

  @override
  _UpcomingAppointMentsDetailsState createState() => _UpcomingAppointMentsDetailsState();
}

enum Status {
  green,
  orange
}

class _UpcomingAppointMentsDetailsState extends State<UpcomingAppointMentsDetails> {

  Widget appointmentDetailsTile({@required String title,@required String subTitle}) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.grey,
                  height: 1.0,
                  fontSize: 14.0
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.0,
                fontSize: 16.0,
                color: Color(0XFF6A6A6A),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Divider(
              height: 1.0,
              indent: 0.0,
            )
          ],
        ),
    );
  }

  Widget appointmentDetailsTileWithStatus({@required String title, @required String subTitle,@required Status status}) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.grey,
                    height: 1.0,
                    fontSize: 14.0
                ),
              ),
              status == Status.green ?
              Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.only(left: 70.0),
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: Color(0XFF1EE3B7),
                  shape: BoxShape.circle,
                ),
              ) : Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.only(left: 100.0),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Color(0XFF1EAEE3),
                  shape: BoxShape.circle,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              height: 1.0,
              fontSize: 16.0,
              color: Color(0XFF6A6A6A),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Divider(
            height: 1.0,
            indent: 0.0,
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Upcoming Appointments"),
      body: Container(
        color: Color(0XFFF3F3F3),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              appointmentDetailsTile(
                title: "Appointment",
                subTitle: "Upcoming Appointment"
              ),
              appointmentDetailsTile(
                title: "Time & Date",
                subTitle: "4:15 PM, November 24, 2018"
              ),
              appointmentDetailsTile(
                title: "Doctor",
                subTitle: "Cuong Ho, PCP"
              ),
              appointmentDetailsTile(
                title: "Practice",
                subTitle: "Mount Sinai Internal Associates"
              ),
              appointmentDetailsTile(
                title: "Claims",
                subTitle: "02"
              ),
              appointmentDetailsTileWithStatus(
                title: "Eligibility",
                subTitle: "Eligible",
                status: Status.green
              ),
              appointmentDetailsTileWithStatus(
                title: "Network",
                subTitle: "In-Network",
                status: Status.green
              ),
              appointmentDetailsTileWithStatus(
                title: "Authorization",
                subTitle: "01",
                status: Status.orange
              ),
              appointmentDetailsTile(
                title: "Referrals",
                subTitle: "Not Needed"
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BaseTheme(
        context: context,
        navigation: CustomBottomNavigation(context: context, index: 4),
      )
    );
  }
}
