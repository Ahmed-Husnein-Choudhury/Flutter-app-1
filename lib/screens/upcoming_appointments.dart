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
    return Container(
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(UpcomingAppointMentsDetails.routeName);
        },
        leading: RichText(
            text: TextSpan(
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: '4:15 ', style: TextStyle(fontSize: 16.0, color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold)),
                new TextSpan(text: 'PM', style: TextStyle(color: Colors.grey)),
              ],
            )
        ),
        title: Text(
          "November 5, 2018",
        ),
        subtitle: Text(
          "Upcoming appointment for Nayra with Chunnu",
          style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0
          ),
        ),
        contentPadding: EdgeInsets.all(10.0),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: Colors.white
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Upcoming Appointments"),
      body: Container(
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return appointmentListTile();
          }
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(context: context,index: 4),
    );
  }
}
