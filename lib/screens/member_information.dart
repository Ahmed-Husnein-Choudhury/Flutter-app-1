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

  // defining the instructional text widget
  Widget instructionalText() {
    return Text(
      "Excellent. We've confirmed your enrollment in <Health Plan>. Please verify your personal information is accurate.",
      style: TextStyle(
          fontSize: 15.0,
          color: Colors.grey
      ),
    );
  }

  // member name and member id label
  Widget memberNameInfoLabel() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              "Name",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Member ID/Medicaid ID",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }

  // member name and member id information
  Widget memberNameInfo() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text("John J Smith JR"),
          ),
          Expanded(
            flex: 1,
            child: Text("M12345678"),
          ),
        ],
      ),
    );
  }

  // member date of birth information
  Widget memberDateOfBirth() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Date of Birth",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold
            ),
          ),
          spacer(gapHeight: 5.0),
          Text("09/24/1974")
        ],
      ),
    );
  }

  // member address information
  Widget memberAddressInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Adress",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold
            ),
          ),
          spacer(gapHeight: 5.0),
          Text(
            "101 Main St\nApt 2\nAnywhere, VA 22222 USA"
          )
        ],
      ),
    );
  }

  // member email information
  Widget memberEmailInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Email",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold
            ),
          ),
          spacer(gapHeight: 5.0),
          Text(
              "jjsmith@domain.com"
          )
        ],
      ),
    );
  }

  // member phone information
  Widget memberPhoneInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Phone",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold
            ),
          ),
          spacer(gapHeight: 5.0),
          Text(
              "(703) 555-1111"
          )
        ],
      ),
    );
  }

  // member information confirmation
  Widget memberInfoConfirmation() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Information Correct ?",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Yes, please continue",
            style: TextStyle(
              fontSize: 15.0
            ),
          ),
          spacer(gapHeight: 10.0),
          confirmationButton(),
          spacer(gapHeight: 10.0),
          Text(
            "No, please contact your health plan",
            style: TextStyle(
                fontSize: 15.0
            ),
          ),
          spacer(gapHeight: 20.0),
          Text(
            "Health Plan 1",
            style: TextStyle(
                fontSize: 15.0
            ),
          ),
          spacer(gapHeight: 5.0),
          Text(
            "Customer Service (880) 555-2222",
            style: TextStyle(
                fontSize: 15.0
            ),
          ),
        ],
      ),
    );
  }

  // defining the confirmation button widget
  Widget confirmationButton() {
    return Container(
      width: 100.0,
      height: 40.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: () {},
        child: Text(
          "Yes",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            spacer(gapHeight: 20.0),
            logo(),
            spacer(gapHeight: 20.0),
            instructionalText(),
            spacer(gapHeight: 20.0),
            memberNameInfoLabel(),
            spacer(gapHeight: 10.0),
            memberNameInfo(),
            spacer(gapHeight: 20.0),
            memberDateOfBirth(),
            spacer(gapHeight: 20.0),
            memberAddressInfo(),
            spacer(gapHeight: 20.0),
            memberEmailInfo(),
            spacer(gapHeight: 20.0),
            memberPhoneInfo(),
            spacer(gapHeight: 20.0),
            memberInfoConfirmation(),
            spacer(gapHeight: 20.0),
          ],
        ),
      ),
    );
  }
}
