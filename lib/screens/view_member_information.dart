import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medicaid/api_and_tokens/api_info.dart';
import 'package:medicaid/api_and_tokens/authentication_token.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:medicaid/models/member.dart';
import 'package:medicaid/screens/facial_setup.dart';
import 'package:medicaid/screens/voice_registration_set_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/screens/home_page.dart';

class ViewMemberInformation extends StatefulWidget {
  // defining the route here
  static final String routeName = "/viewMemberInformation";

  @override
  _ViewMemberInformationState createState() => _ViewMemberInformationState();
}

class _ViewMemberInformationState extends State<ViewMemberInformation> {
  Member member;
  final formatter = new NumberFormat("###-###-####");
  String numberFormat = "###-###-####";
  String phoneNumber;
  int pNumber;
  List<String> subString;
  int numberFormatCounter = 0;

  @override
  initState() {
    super.initState();
    // phoneNumber=this.member.contactInfo.primaryPhoneNumber;
    // saveMemberNumber();
//    while(numberFormatCounter<=2){
//     subString.add(splitString(phoneNumber,0,2));
//
//    }
  }

  String splitString(String inputString, int startIndex, int endIndex) {
    String outputString = inputString.substring(0, 2);
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
      "Excellent. We've confirmed your enrollment in ${this.member.medicaidInfo.memberPlan.planName}. Please verify whether your personal information is accurate.",
      style: TextStyle(fontSize: 15.0, color: Colors.grey),
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
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Member ID/Medicaid ID",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
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
            child: Text(this.member.demographic.firstName +
                " " +
                this.member.demographic.lastName),
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
                fontWeight: FontWeight.bold),
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
            "Address",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          spacer(gapHeight: 5.0),
          Text(
              "${this.member.location.streetAddressOne}\n${this.member.location.addressCity}"
              "\n${this.member.location.addressState}, ${this.member.location.addressZip.substring(0, 5)}")
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
                fontWeight: FontWeight.bold),
          ),
          spacer(gapHeight: 5.0),
          Text(this.member.contactInfo.emailAddress)
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
                fontWeight: FontWeight.bold),
          ),
          spacer(gapHeight: 5.0),
          Text(this.member.contactInfo.primaryPhoneNumber)
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
            "Is the Information Correct?",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          spacer(gapHeight: 10.0),
          confirmationButton(),
          spacer(gapHeight: 10.0),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14.0, height: 1.2),
              children: [
                TextSpan(
                  text:
                      "If it is incorrect, please contact our ${this.member.medicaidInfo.memberPlan.planName.toUpperCase()} Customer Service Team"
                      " directly at ",
                  style: new TextStyle(color: Colors.black),
                ),
                TextSpan(
                    text: '(800) 555-2222',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        String url = "tel:800555-2222";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }),
              ],
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
                  builder: (context) => HomePage()
                      ));
        },
        child: Text(
          "Yes",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }

  Future<Member> getMemberInformation() async {
    SharedPreferences MemberIdPref = await SharedPreferences.getInstance();
    String url = ApiInfo.getBaseUrl();
    final response = await get(
      url + "/api/v1/members/${MemberIdPref.getString("member number")}",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": AuthenticationToken.getToken()
      },
    );

    print("response from member information api:${response.body}");
    print("authentication token:${AuthenticationToken.getToken()}");
    member = Member.fromJson(json.decode(response.body));

    return member;
  }

  Widget showMemberInformation(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Member Information"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
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

  Widget progressIndicator() {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image(image: AssetImage("assets/loading_animation_03.gif")),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMemberInformation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (member != null) {
              return showMemberInformation(context);
            }
          } else {
            return progressIndicator();
          }
        });
  }
}