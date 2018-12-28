import 'package:flutter/material.dart';
import 'package:medicaid/member.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';
import 'package:medicaid/screens/facial_setup.dart';

class MemberInformation extends StatefulWidget {

  // defining the route here
  static final String routeName = "/memberInformation";

  String responseData;
  MemberInformation({this.responseData});

  @override
  _MemberInformationState createState() => _MemberInformationState();
}

class _MemberInformationState extends State<MemberInformation> {

  Member member;

  @override
  initState() {
    super.initState();
    this.member = Member.fromJson(json.decode(widget.responseData));
  }

  String formatDate(String date) {
    List<String> formattedDate = date.split("-");
    return "${formattedDate[1]}/${formattedDate[2]}/${formattedDate[0]}";
  }

  // widget for showing logo
  Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.png",
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
      "Excellent. We've confirmed your enrollment in ${this.member.medicaidInfo.memberPlan.planName}. Please verify your personal information is accurate.",
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
            child: Text(this.member.clientInfo.clientName),
          ),
          Expanded(
            flex: 1,
            child: Text(this.member.memberNumber),
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
          Text(formatDate(this.member.demographic.dateOfBirth))
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
            "${this.member.location.streetAddressOne}\n${this.member.location.addressCity}"
                "\n${this.member.location.addressState}, ${this.member.location.addressZip}"
                " USA"
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
              this.member.contactInfo.emailAddress
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
              this.member.contactInfo.primaryPhoneNumber
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
            this.member.medicaidInfo.memberPlan.planName,
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FacialRecognitionSetup(
                healthPlanName: this.member.medicaidInfo.memberPlan.planName,
              )
            )
          );
        },
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
