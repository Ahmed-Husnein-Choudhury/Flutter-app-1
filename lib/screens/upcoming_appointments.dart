import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/screens/upcoming_appointments_details.dart';

class UpcomingAppointments extends StatefulWidget {

  static const String routeName = "/upcomingAppointments";

  @override
  _UpcomingAppointmentsState createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {

  Widget appointmentListTile () {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.white,
      child: Container(
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(UpcomingAppointMentsDetails.routeName);
          },
          leading: Container(
            decoration: ShapeDecoration(
              color: Color(0XFF00AFDF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              )
            ),
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.watch_later, color: Colors.white,),
          ),
          title: Text(
            "Upcoming Appointment",
            style: TextStyle(
                color: Color(0XFF6A6A6A),
                fontSize: 15.0
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "11/17/18 | 8:00am",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
              ),
              Text(
                "Appointment details listed here",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0
                ),
              ),
            ],
          ),
          isThreeLine: true,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Upcoming Appointments"),
      body: Container(
        color: Color(0XFFF3F3F3),
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return appointmentListTile();
          }
        ),
      ),
      bottomNavigationBar: BaseTheme(
        context: context,
        navigation: CustomBottomNavigation(context: context, index: 4),
      )
    );
  }
}
