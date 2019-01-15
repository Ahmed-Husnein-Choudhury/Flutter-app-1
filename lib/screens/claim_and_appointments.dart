import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/screens/claim_and_appointments_details.dart';

class ClaimsAndAppointments extends StatefulWidget {

  static const String routeName = "/claimAndAppointMents";

  @override
  _ClaimsAndAppointmentsState createState() => _ClaimsAndAppointmentsState();
}

class _ClaimsAndAppointmentsState extends State<ClaimsAndAppointments> {

  var names=["Ben Hoefs","Ahmed Husnein Choudhury"];


  Widget singleRow({@required String providerName, @required String visitingDate, @required String processedDate, @required String purpose, @required double oweAmount}) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ClaimAndAppointmentsDetails.routeName);
        },
        child: Card(
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            margin: EdgeInsets.only(top: 2.5, bottom: 5, left: 5.0, right: 5.0),
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
                                  color: Color(0XFF00AFDF)
                              ),
                            ),
                            Text(
                              "$providerName visits on $visitingDate",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0XFF6A6A6A)
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
                              "\$${oweAmount.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Color(0XFF1676B3)
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
        color: Color(0XFFF3F3F3),
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return singleRow(
              providerName: names[index],
              visitingDate: "9 Sep, 2018",
              processedDate: "9 Sep, 2018",
              oweAmount: 4.200,
              purpose: "Medical Services"
            );
          }
        )
      ),

      bottomNavigationBar: BaseTheme(
        context: context,
        navigation: CustomBottomNavigation(context: context, index: 4),
      )
    );
  }
}
