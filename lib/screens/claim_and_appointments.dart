import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/screens/claim_and_appointments_details.dart';

class ClaimsAndAppointments extends StatefulWidget {

  static const String routeName = "/claimAndAppointMents";

  @override
  _ClaimsAndAppointmentsState createState() => _ClaimsAndAppointmentsState();
}

class _ClaimsAndAppointmentsState extends State<ClaimsAndAppointments> {

  Widget singleRow({@required String providerName, @required String visitingDate, @required String processedDate, @required String purpose, @required double oweAmount}) {
    return Container(
      color: Color(0XFFF9FAFF),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(ClaimAndAppointmentsDetails.routeName);
        },
        child: Card(
            elevation: 0.0,
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
            margin: EdgeInsets.only(top: 2.5, bottom: 2.5),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Provider: $providerName",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent
                              ),
                            ),
                            Text(
                              "$providerName visits on $visitingDate",
                              style: TextStyle(
                                  fontSize: 12.0
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Processed on: $processedDate",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0
                              ),
                            ),
                            Text(
                              purpose,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "You may owe",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0
                              ),
                            ),
                            Text(
                              "\$$oweAmount",
                              style: TextStyle(
                                  color: Color(0XFFB678F9)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Claim & Appointments"),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return singleRow(
              providerName: "Jonathon Doe",
              visitingDate: "9 Sep, 2018",
              processedDate: "9 Sep, 2018",
              oweAmount: 4.20,
              purpose: "Medical Services"
            );
          }
        )
      ),
      bottomNavigationBar: CustomBottomNavigation(context: context,index: 4),
    );
  }
}
