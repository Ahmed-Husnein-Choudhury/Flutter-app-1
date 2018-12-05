import 'package:flutter/material.dart';

class MemberVerification extends StatefulWidget {

  // defining the route here
  static final String routeName = "/memberVerification";

  String emailAddress, mobileNumber;

  //constructor
  MemberVerification({String email, String mobile}) {
    this.emailAddress = email;
    this.mobileNumber = mobile;
  }


  @override
  _MemberVerificationState createState() => _MemberVerificationState();
}

class _MemberVerificationState extends State<MemberVerification> {

  int groupValue;
  String obscureEmail, obscureMobile, selectedMethod;

  @override
  void initState() {
    super.initState();
    this.groupValue = 1;
    this.obscureEmail = widget.emailAddress;
    this.obscureMobile = widget.mobileNumber;
    obscureEmailAddress();
    obscureMobileNumber();
  }

  void obscureEmailAddress() {
    int breakPosition = this.obscureEmail.indexOf("@");
    String initialPart, obscurePart, extension;
    if (breakPosition >= 5) {
      initialPart = this.obscureEmail.substring(0,3);
      obscurePart = this.obscureEmail.substring(3, breakPosition);
      extension = this.obscureEmail.substring(breakPosition, this.obscureEmail.length);

      this.obscureEmail = initialPart + obscurePart.replaceAll(new RegExp(r'[a-zA-Z0-9\_\.\!\#\$\%\&\*\+\-\/\=\?\^\_\`\~]'), '*') + extension;
      print(this.obscureEmail);
    } else {
      initialPart = this.obscureEmail.substring(0,2);
      obscurePart = this.obscureEmail.substring(2, 5);
      extension = this.obscureEmail.substring(5, this.obscureEmail.length);

      this.obscureEmail = initialPart + obscurePart.replaceAll(new RegExp(r'[a-zA-Z0-9\_\.\!\#\$\%\&\*\+\-\/\=\?\^\_\`\{|}~]'), '*') + extension;
      print(this.obscureEmail);
    }
  }

  void obscureMobileNumber() {
    this.obscureMobile = this.obscureMobile.substring(6,10);
    print(this.obscureMobile);
  }

  void changeVerificationMethod(int val) {
    setState(() {
      if (val == 1) {
        this.groupValue = 1;
      } else {
        this.groupValue = 2;
      }
    });
  }

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
      "Please choose a method to recieve a verification code.",
      style: TextStyle(
        fontSize: 15.0,
      ),
    );
  }

  // verification code sent options
  Widget verificationCodeSendOption() {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              changeVerificationMethod(1);
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Radio(
                    value: 1,
                    groupValue: this.groupValue,
                    activeColor: Colors.blue,
                    onChanged: (int val) {
                      changeVerificationMethod(val);
                    },
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    obscureEmail
                  ),
                )
              ],
            ),
          ),
          spacer(gapHeight: 10.0),
          GestureDetector(
            onTap: () {
              changeVerificationMethod(2);
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Radio(
                    value: 2,
                    groupValue: this.groupValue,
                    activeColor: Colors.blue,
                    onChanged: (int val) {
                      changeVerificationMethod(val);
                    },
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                      "***-***-$obscureMobile"
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Request verification code button widget
  Widget verificationCodeButton() {
    return MaterialButton(
      onPressed: _showVerificationCodeSentDialog,
      height: 40.0,
      padding: EdgeInsets.all(15.0),
      minWidth: 200.0,
      color: Color(0XFF00AFDF),
      textColor: Colors.white,
      child: Text(
        "Request Verification Code",
        style: TextStyle(
            fontSize: 18.0,
            color: Colors.white
        ),
      ),
        shape: Border.all(
          width: 1.0
        ),
    );
  }

  // success alert upon compilation of sending verification code
  void _showVerificationCodeSentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Verification Code Sent',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10.0),
                  ),
                  Divider(
                    height: 2.0,
                  )
                ],
              ),
            ),
            content: Container(
              height: 180.0,
              child: Column(
                children : <Widget>[
                  this.groupValue == 1 ? Text(
                    "A verification code has sent to $obscureEmail. Please check your email and verify your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.0
                    ),
                  ) : Text(
                    "A verification code has sent to ***-***-$obscureMobile. Make sure you got the code and verify.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.0
                    ),
                  ),
                  spacer(gapHeight: 25.0),
                  RaisedButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
            )
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              spacer(gapHeight: 20.0),
              logo(),
              spacer(gapHeight: 30.0),
              instructionalText(),
              spacer(gapHeight: 30.0),
              verificationCodeSendOption(),
              spacer(gapHeight: 30.0),
              verificationCodeButton(),
              spacer(gapHeight: 30.0),
            ],
          ),
        ),
      )
    );
  }
}
