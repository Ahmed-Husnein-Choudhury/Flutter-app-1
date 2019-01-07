import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/screens/all_information_confirmed_details.dart';

class InformationConfirmed extends StatefulWidget {
  static final String routeName = "/informationConfirmed";

  @override
  _InformationConfirmedState createState() => _InformationConfirmedState();
}

class _InformationConfirmedState extends State<InformationConfirmed> {
  static final INFO_CONFIRMED = "All Information Confirmed";
  String _hospitalName = "Mount Sinai Internal Medicine Associates";
  static final GOVT_ISSUED_ID =
      "Show your government issued ID as well as the information below during the practice's check-in process.";
  static final appBarTextColor = 0XFF8785FF;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AllInformationConfirmedDetails()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget textView(String text) {
      return new Text(text,
          style: TextStyle(fontSize: 15.00, color: Colors.black54));
    }

    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: CustomAppBar(title: INFO_CONFIRMED),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: new Container(
                child: new Padding(
              padding: EdgeInsets.fromLTRB(31.00, 87.00, 40.00, 0.00),
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Padding(padding: EdgeInsets.fromLTRB(58.01, 94.00,  51.99, 0.00)),
                    // new Padding(padding: EdgeInsets.only(top:94.00 )),
                    new Text(
                      "Excellent!",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Color(0XFF00AFDF),
                          fontWeight: FontWeight.bold),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 50.00)),
                    textView("You are confirmed at"),
                    new Padding(padding: EdgeInsets.only(top: 10.00)),

                    new Text(
                      _hospitalName,
                      style: TextStyle(
                          fontSize: 17.00,
                          color: Color(0XFF6A6A6A),
                          fontWeight: FontWeight.bold),
                    ),

                    new Padding(padding: EdgeInsets.only(top: 30.00)),

                    textView(GOVT_ISSUED_ID),

                    new Padding(padding: EdgeInsets.only(bottom: 20.00)),
                  ],
                ),
              ),
            )),
          ),
          bottomNavigationBar: BaseTheme(
            context: context,
            navigation: CustomBottomNavigation(context: context, index: 4),
          ),
        ));
  }
}
