import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:medicaid/screens/member_information.dart';

class MemberVerification extends StatefulWidget {

  // defining the route here
  static final String routeName = "/memberVerification";

  String memberID, emailAddress, mobileNumber;

  //constructor
  MemberVerification({String memberId, String email, String mobile}) {
    this.memberID = memberId;
    this.emailAddress = email;
    this.mobileNumber = mobile;
  }

  @override
  _MemberVerificationState createState() => _MemberVerificationState();
}

class _MemberVerificationState extends State<MemberVerification> {
  int groupValue;
  String obscureEmail, obscureMobile, selectedMethod, codeSent;
  bool isCodeSent = false, _validate = false;

  // global form key
  GlobalKey<FormState> verificationFormKey = GlobalKey();

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
      initialPart = this.obscureEmail.substring(0, 3);
      obscurePart = this.obscureEmail.substring(3, breakPosition);
      extension =
          this.obscureEmail.substring(breakPosition, this.obscureEmail.length);

      this.obscureEmail = initialPart +
          obscurePart.replaceAll(
              new RegExp(r'[a-zA-Z0-9\_\.\!\#\$\%\&\*\+\-\/\=\?\^\_\`\~]'),
              '*') +
          extension;
      print(this.obscureEmail);
    } else {
      initialPart = this.obscureEmail.substring(0, 2);
      obscurePart = this.obscureEmail.substring(2, 5);
      extension = this.obscureEmail.substring(5, this.obscureEmail.length);

      this.obscureEmail = initialPart +
          obscurePart.replaceAll(
              new RegExp(r'[a-zA-Z0-9\_\.\!\#\$\%\&\*\+\-\/\=\?\^\_\`\{|}~]'),
              '*') +
          extension;
      print(this.obscureEmail);
    }
  }

  void obscureMobileNumber() {
    this.obscureMobile = this.obscureMobile.substring(6, 10);
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
        color: Colors.grey
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
                  child: Text(obscureEmail),
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
                  child: Text("***-***-$obscureMobile"),
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
      onPressed: sendVerificationCode,
      height: 40.0,
      padding: EdgeInsets.all(15.0),
      minWidth: 200.0,
      color: Color(0XFF00AFDF),
      textColor: Colors.white,
      child: Text(
        "Request Verification Code",
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      shape: Border.all(width: 1.0),
    );
  }

  // verify code fields label widget
  Widget verifyCodeFieldLabel() {
    return Container(
      alignment: AlignmentDirectional.topStart,
      child: Text(
        "Enter verification code",
        style: TextStyle(
          fontSize: 15.0
        ),
      ),
    );
  }

  // validation rules for verification code
  String validateCodeSentField(String code) {
    if (code.length == 0) {
      return "Vefication code can not be empty";
    } else {
      return null;
    }
  }

  // verify code field widget
  Widget verifyCodeField() {
    return Container(
      child: TextFormField(
        maxLength: 6,
        maxLines: 1,
        autofocus: true,
        validator: validateCodeSentField,
        keyboardType: TextInputType.number,
        onSaved: (String sentCode) {
          this.codeSent = sentCode;
        },
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0)
          )
        ),
      ),
    );
  }

  // verify code field
  Widget verifyCodeContainer() {
    return Form(
      autovalidate: _validate,
      key: verificationFormKey,
      child: Container(
        child: Column(
          children: <Widget>[
            verifyCodeFieldLabel(),
            spacer(gapHeight: 10.0),
            verifyCodeField(),
            spacer(gapHeight: 20.0),
            verifyButton(),
            spacer(gapHeight: 10.0),
          ],
        ),
      )
    );
  }

  // Verify button widget
  Widget verifyButton() {
    return MaterialButton(
      onPressed: verifyCodeSent,
      height: 30.0,
      padding: EdgeInsets.all(15.0),
      minWidth: 100.0,
      color: Color(0XFF00AFDF),
      textColor: Colors.white,
      child: Text(
        "Verify",
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
      shape: Border.all(
        width: 1.0,
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
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
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
                children: <Widget>[
                  this.groupValue == 1
                      ? Text(
                          "A verification code has sent to $obscureEmail. Please check your email and verify your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        )
                      : Container(),
                  spacer(gapHeight: 25.0),
                  RaisedButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        this.isCodeSent = true;
                      });
                    }
                  )
                ],
              ),
            )
        );
      },
    );

  }

  // error alert when failed to match verification code
  void _showErrorMessageOnVerificationFailed() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Verification Error',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Divider(
                    height: 2.0,
                  )
                ],
              ),
            ),
            content: Container(
              height: 200.0,
              child: Column(
                children: <Widget>[
                  this.groupValue == 1
                      ? Text(
                    "THe information provided could not be validated. Please request a new verification code and try again."
                        "If you continue to receive this error, please contact Customer Service at (800)555-2222",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0, color: Colors.red),
                  )
                      : Container(),
                  spacer(gapHeight: 25.0),
                  RaisedButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                  )
                ],
              ),
            )
        );
      },
    );

  }

  // send verification code
  Future sendVerificationCode() async {
    String url = "http://192.168.1.37:8008/api/v1/send_verification_code";

    var body = {
      "method": "EMAIL",
      "member_number": widget.memberID
    };

    var response = await post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body:  json.encode(body)
    );

    if (response.statusCode == 200) {
      _showVerificationCodeSentDialog();
    } else {
      print(response.statusCode.toString());
    }
  }

  // verify verification code snet
  Future verifyVerificationCodeSent() async {
    String url = "http://192.168.1.37:8008/api/v1/verify_verification_code";

    var body = {
      "method": "EMAIL",
      "member_number": widget.memberID,
      "verification_code": this.codeSent
    };

    var response = await post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body:  json.encode(body)
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed(MemberInformation.routeName);
      String responseBody = response.body;
      print(responseBody);
    } else {
      _showErrorMessageOnVerificationFailed();
    }
  }

  // verify sent code
  void verifyCodeSent() {
    if (verificationFormKey.currentState.validate()) {
      verificationFormKey.currentState.save();
      verifyVerificationCodeSent();
    } else {
      setState(() {
        _validate = true;
      });
    }
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
              spacer(gapHeight: 20.0),
              verificationCodeButton(),
              spacer(gapHeight: 30.0),
              this.isCodeSent ?
              verifyCodeContainer() : Container()
            ],
          ),
        ),
    ));
  }
}
