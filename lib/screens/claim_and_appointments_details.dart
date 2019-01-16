import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';

class ClaimAndAppointmentsDetails extends StatefulWidget {

  static const String routeName = "/claimAndAppointmentDetails";

  @override
  _ClaimAndAppointmentsDetailsState createState() => _ClaimAndAppointmentsDetailsState();
}

enum Status {
  green,
  orange,
  purple,
  lightPurple
}

class _ClaimAndAppointmentsDetailsState extends State<ClaimAndAppointmentsDetails> {

  final double PERCENTAGE = 200.0;
  double owedAmount=4.20;

  Widget appointmentDetailsTileWithStatus({@required String title, @required String subTitle, Status status}) {
    if (status == Status.green) {
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
                      color: Color(0XFF6A6A6A),
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                      fontSize: 16.0
                    ),
                  ),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.only(left: 110.0),
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      color: Color(0XFF1EE3B7),
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
                    color: Color(0XFFA9A9A9),
                    height: 1.0,
                    fontSize: 14.0
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
      );
    } else if (status == Status.orange) {
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
                    color: Color(0XFF6A6A6A),
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    fontSize: 16.0
                  ),
                ),
                Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.only(left: 100.0),
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    color: Color(0XFF00AFDF),
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
                  color: Color(0XFFA9A9A9),
                  height: 1.0,
                  fontSize: 14.0
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      );
    } else if (status == Status.purple) {
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
                      color: Color(0XFF6A6A6A),
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                      fontSize: 16.0
                  ),
                ),
                Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.only(left: 110.0),
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    color: Color(0XFF1676B3),
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
                  color: Color(0XFFA9A9A9),
                  height: 1.0,
                  fontSize: 14.0
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      );
    } else {
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
                Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.only(left: 75.0),
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    color: Color(0XFFD0D5FC),
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
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      );
    }
  }

  Widget claimDetails({@required String title, @required String subTitle}) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Color(0XFFA9A9A9),
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
        ],
      ),
    );
  }

  Widget showPercentage ({@required double percentage, @required double billedAmount, @required double paidAmount, @required double discount}) {
    double calculatedPercent = PERCENTAGE - (PERCENTAGE * percentage);
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                  width: 50.0,
                  child: Container(
                    color: Color(0XFF1EE3B7),
                  ),
                ),
                SizedBox(
                  height: calculatedPercent,
                  width: 50.0,
                  child: Container(
                    color: Color(0XFFD4D4D4),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  appointmentDetailsTileWithStatus(
                    title: "Amount Billed",
                    subTitle: "\$${billedAmount.toStringAsFixed(2)}",
                    status: Status.green
                  ),
                  appointmentDetailsTileWithStatus(
                    title: "Paid by Plan",
                    subTitle: "\$${paidAmount.toStringAsFixed(2)}",
                    status: Status.orange
                  ),
                  appointmentDetailsTileWithStatus(
                    title: "Plan Discount",
                    subTitle: "\$${discount.toStringAsFixed(2)}",
                    status: Status.purple
                  )
                ],
              ),
            ),
          )
        ]
      ),
    );
  }

  Widget claimOptions () {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: ShapeDecoration(
                color: Color(0XFF00AFDF),
                shape: StadiumBorder(
                  side: BorderSide(
                    width: 1.0,
                    color: Color(0XFF00AFDF)
                  ),
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.flag, color: Colors.white,),
                  SizedBox(width: 5.0,),
                  Text(
                    "Flag",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(

            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: ShapeDecoration(
                  color: Color(0XFF00AFDF),
                  shape: StadiumBorder(
                    side: BorderSide(
                        width: 1.0,
                        color: Color(0XFF00AFDF)
                    ),
                  )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.event_note, color: Colors.white,),
                  SizedBox(width: 5.0,),
                  Text(
                    "Notes",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(

            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: ShapeDecoration(
                  color: Color(0XFF00AFDF),
                  shape: StadiumBorder(
                    side: BorderSide(
                        width: 1.0,
                        color: Color(0XFF00AFDF)
                    ),
                  )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.monetization_on, color: Colors.white,),
                  SizedBox(width: 5.0,),
                  Text(
                    "Mark Paid",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Claim & Past Appointments"),
      body: Container(
        color: Color(0XFFF3F3F3),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              showPercentage(
                percentage: 0.7,
                billedAmount: 16.00,
                paidAmount: 00.00,
                discount: 11.62
              ),
              Divider(height: 1.0),
              claimDetails(
                title: "You may owe",
                subTitle: "\$${owedAmount.toStringAsFixed(2)}"
              ),
              Divider(height: 1.0),
              claimOptions(),
              Divider(height: 1.0),
              claimDetails(
                title: "Provider",
                subTitle: "Dr. Johnson"
              ),
              Divider(height: 1.0),
              claimDetails(
                title: "ID",
                subTitle: "12345678"
              ),
              Divider(height: 1.0),
              claimDetails(
                title: "Patient",
                subTitle: "Michele"
              ),
              Divider(height: 1.0),
              claimDetails(
                title: "Occured",
                subTitle: "11/26/2018"
              ),
              Divider(height: 1.0),
              claimDetails(
                title: "Applied to Deductible",
                subTitle: "\$4.52"
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
