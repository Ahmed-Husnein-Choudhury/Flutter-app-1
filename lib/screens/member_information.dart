import 'package:flutter/material.dart';

class MemberInformation extends StatefulWidget {

  // defining the route here
  static final String routeName = "/memberInformation";

  @override
  _MemberInformationState createState() => _MemberInformationState();
}

class _MemberInformationState extends State<MemberInformation> {

  // widget for showing logo
  Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.jpg",
        height: 100.0,
      ),
    );
  }

  // dynamic gap widget
  Widget spacer({@required double gapHeight}) {
    return SizedBox(
      height: gapHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
