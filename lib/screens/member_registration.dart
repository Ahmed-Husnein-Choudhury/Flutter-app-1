import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:medicaid/screens/member_verification.dart';
import 'package:medicaid/utils/common_widgets.dart';

String fullName, phoneNumber;

class MemberRegistration extends StatefulWidget {
  // defining the route here
  static final String routeName = "/memberRegistration";

  @override
  _MemberRegistrationState createState() => _MemberRegistrationState();
}

class _MemberRegistrationState extends State<MemberRegistration> {
  // global form key to validate input fields
  GlobalKey<FormState> formKey = new GlobalKey();
  bool _validate = false;
  List<String> _genderOptions = new List<String>();

  // form fields
  String memberId,
      dateOfBirth,
      gender,
      email,
      confirmEmail,
      mobileNumber,
      processedGender,
      firstName,
      lastName;

  int _year;
  int _month;
  int _date;
  String _format = 'mm-dd-yyyy';
  bool isDateButtonDisabled = false;

  // controller for dateOfBirth
  final dobController = new TextEditingController();
  final String baseUrl = "http://ec2-3-83-176-152.compute-1.amazonaws.com:8008";

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _date = now.day;

    dobController.text = "$_month/$_date/$_year";
    this.dateOfBirth = "$_year-$_month-$_date";

    _genderOptions.addAll(["Male", "Female", "Transgender", "Non-Conforming"]);
    gender = null;
  }

  // alert dialog if date is invalid
  void _showInvalidDateDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              "Invalid Date",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
            content: Text(
              "You can't choose a future date!!!",
            ),
            actions: <Widget>[
              RaisedButton(
                  color: Color(0XFF00AFDF),
                  shape: StadiumBorder(
                    side: BorderSide(
                      width: 1.0,
                      color: Color(0XFF00AFDF),
                    ),
                  ),
                  child: Text("Close",
                      style: TextStyle(color: Colors.white, fontSize: 15.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
              /*new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),*/
            ],
          );
        });
  }

  // alert dialog if email and confirm email do not match
  void _showMismatchEmailDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              "Email Mismatch!",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
            content: Text(
              "Your given email and confirm email do not match each other",
            ),
            actions: <Widget>[
              RaisedButton(
                  color: Color(0XFF00AFDF),
                  shape: StadiumBorder(
                    side: BorderSide(
                      width: 1.0,
                      color: Color(0XFF00AFDF),
                    ),
                  ),
                  child: Text("Close",
                      style: TextStyle(color: Colors.white, fontSize: 15.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  // success alert upon compilation of member registration
  void _showVerificationErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
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
              height: 180.0,
              child: Column(
                children: <Widget>[
                  Text(
                    "Please recheck the information entered and resubmit. If you continue to receive this message,"
                        "please contact us at Customer Service (880) 555-2222",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0),
                  ),
                  spacer(gapHeight: 25.0),
                  RaisedButton(
                      color: Color(0XFF00AFDF),
                      shape: StadiumBorder(
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0XFF00AFDF),
                        ),
                      ),
                      child: Text("Ok",
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.0)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
            ));
      },
    );
  }

  // process gender for sending to server
  void processGender(String gender) {
    if (gender == "Male") {
      this.processedGender = "M";
    } else if (gender == "Female") {
      this.processedGender = "F";
    } else if (gender == "Transgender") {
      this.processedGender = "T";
    } else if (gender == "Non-Conforming") {
      this.processedGender = "N";
    }
    print(this.processedGender);
  }

  // send data to server
  Future _sendDataToServer() async {
    fullName = firstName + lastName;
    phoneNumber = mobileNumber;
    // url to hit
    final String url = "${baseUrl}/api/v1/verify_member_account/";

    var body = {
      "member_number": this.memberId,
      "date_of_birth": this.dateOfBirth,
      "first_name": this.firstName,
      "last_name": this.lastName,
      "gender": this.processedGender,
      "email_address": this.email,
      "primary_phone_number": this.mobileNumber,
    };

    var response = await post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode(body));

    print(response);

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemberVerification(
              memberId: this.memberId,
              email: this.email,
              mobile: this.mobileNumber),
        ),
      );
    } else {
      _showVerificationErrorDialog();
    }
  }

  /// Display date picker.
  void _showDatePicker() {
    setState(() {
      isDateButtonDisabled = true;
    });
    print("logging from date picker");
    DatePicker.showDatePicker(
      context,
      minYear: 1920,
      maxYear: DateTime.now().year,
      initialYear: _year,
      initialMonth: _month,
      initialDate: _date,
      locale: 'en',
      confirm: Text(
        'Ok',
        style: TextStyle(color: Colors.green),
      ),
      cancel: Text(
        'Cancel',
        style: TextStyle(color: Colors.red),
      ),
      dateFormat: _format,
      onChanged: (year, month, date) {
        setState(() {
          this.dateOfBirth = "$_year-$_month-$_date";
          dobController.text = "$_month/$_date/$_year";
        });
        /*if (date > this._date) {
          _showInvalidDateDialog();
        } else {

        }*/
      },
      onConfirm: (year, month, date) {
        _changeDatetime(year, month, date);
        setState(() {
          this.dateOfBirth = "$_year-$_month-$_date";
          dobController.text = "$_month/$_date/$_year";
        });
      },
    );
    setState(() {
      isDateButtonDisabled = false;
    });
  }

  void _changeDatetime(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      this.dateOfBirth = '$year-$month-$date';
    });
  }

  // method to check whether the email and the confirm email is same or not
  bool isEmailMatched(String email, String confirmEmail) {
    if (email == confirmEmail) {
      return true;
    }
    return false;
  }

  // validation rules for memberID field
  String validateMemberID(String memberID) {
    if (memberID.length == 0) {
      return "Member ID required";
    } else if (memberID.length != 9) {
      return "Invalid Member ID";
    } else {
      return null;
    }
  }

  // validation rules for dateOfBirth field
  String validateDateOfBirth(String dob) {
    if (dob.length == 0) {
      return "DOB is required";
    }
    return null;
  }

  // validation rules for firstName field
  String validateFirstName(String firstName) {
    if (firstName.length == 0) {
      return "First name is required";
    }
    return null;
  }

  // validation rules for lastName field
  String validateLastName(String lastName) {
    if (lastName.length == 0) {
      return "Last name is required";
    }
    return null;
  }

  // validation rules for email address
  String validateEmail(String email) {
    if (email.length == 0) {
      return "Email is required";
    } else {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(email))
        return 'Enter valid email';
      else
        return null;
    }
  }

  // validation rules for email confirmation
  String validateEmailConfirmation(String email) {
    if (email.length == 0) {
      return "Confirm email is required";
    } else {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(email))
        return 'Enter valid email';
      else
        return null;
    }
  }

  // validation rules for phone number
  String validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 0) {
      return "Mobile number is required";
    } else if (phoneNumber.length != 10) {
      return "Invalid mobile number length";
    } else {
      return null;
    }
  }

  void saveMemberInfo() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      // matching the given email and confirm email here
      if (this.isEmailMatched(email, confirmEmail)) {
        this.processGender(this.gender);
        _sendDataToServer();
      } else {
        CommonWidgets.showErrorAlertDialog(
            context: context,
            title: "Email Mismatch",
            content: "The confirmed email do not match with the given email",
            confirmationText: "Ok",
            height: 120.0);
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
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

  // widget for choosing date of birth
  Widget dobField(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.datetime,
      controller: dobController,
      textInputAction: TextInputAction.none,
      onTap: !isDateButtonDisabled ? _showDatePicker : null,
      focusNode: FocusNode(),
      decoration: InputDecoration(
        labelText: "Date of Birth*",
      ),
    );
  }

  // defining the instructional text widget
  Widget instructionalText() {
    return Text(
      "Great! In order to match you to your records, please submit your personal information below.",
      style: TextStyle(
        fontSize: 15.0,
      ),
    );
  }

  // member id widget
  Widget memberIdField() {
    return Container(
      alignment: Alignment.topLeft,
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: validateMemberID,
        onSaved: (String memberId) {
          this.memberId = memberId;
        },
        decoration: InputDecoration(
          labelText: "Member ID/Medicaid ID*",
        ),
      ),
    );
  }

  // first name widget
  Widget firstNameField() {
    return TextFormField(
      validator: validateFirstName,
      onSaved: (String firstName) {
        this.firstName = firstName;
      },
      decoration: InputDecoration(labelText: "First name*"),
    );
  }

  // last name widget
  Widget lastNameField() {
    return TextFormField(
      validator: validateLastName,
      onSaved: (String lastName) {
        this.lastName = lastName;
      },
      decoration: InputDecoration(labelText: "Last name*"),
    );
  }

  // name widget
  Widget nameFieldRow() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: firstNameField(),
            flex: 3,
          ),
          Expanded(
            child: SizedBox(),
            flex: 1,
          ),
          Expanded(
            child: lastNameField(),
            flex: 3,
          ),
        ],
      ),
    );
  }

  void _setGender(String gender) {
    setState(() {
      this.gender = gender;
    });
  }

  // gender widget
  Widget genderWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 28.0),
            child: DropdownButton(
          hint: Text("Gender",style: TextStyle(fontSize:18.0 ),),
          value: gender,
          items: _genderOptions.map((String gender) {
            return DropdownMenuItem(value: gender, child: Text("" + gender));
          }).toList(),
          onChanged: (String gender) {
            _setGender(gender);
          },
        ))
      ],
    );
  }

  // email widget
  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (String email) {
        this.email = email;
      },
      decoration: InputDecoration(labelText: "Email Address*"),
    );
  }

  // confirm email widget
  Widget confirmEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: validateEmailConfirmation,
      onSaved: (String confirmedEmail) {
        this.confirmEmail = confirmedEmail;
      },
      decoration: InputDecoration(labelText: "Confirm Email Address*"),
    );
  }

  // Mobile number widget
  Widget mobileNumberField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      maxLength: 10,
      validator: validatePhoneNumber,
      onSaved: (String phoneNumber) {
        this.mobileNumber = phoneNumber;
      },
      decoration: InputDecoration(labelText: "Mobile Number*"),
    );
  }

  // defining the confirmation button widget
  Widget confirmationButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: saveMemberInfo,
        child: Text(
          "Continue",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        shape: StadiumBorder(
          side: BorderSide(
            width: 1.0,
            color: Color(0XFF00AFDF),
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
          child: Form(
            key: formKey,
            autovalidate: _validate,
            child: Column(
              children: <Widget>[
                spacer(gapHeight: 20.0),
                logo(),
                spacer(gapHeight: 20.0),
                instructionalText(),
                spacer(gapHeight: 20.0),
                memberIdField(),
                spacer(gapHeight: 20.0),
                nameFieldRow(),
                spacer(gapHeight: 20.0),
                dobFieldGenderRow(context),
//              spacer(gapHeight: 20.0),
//              genderWidget(),
                spacer(gapHeight: 20.0),
                emailField(),
                spacer(gapHeight: 20.0),
                confirmEmailField(),
                spacer(gapHeight: 20.0),
                mobileNumberField(),
                spacer(gapHeight: 20.0),
                confirmationButton(),
                spacer(gapHeight: 20.0),
              ],
            ),
          )),
    );
  }

  Widget dobFieldGenderRow(BuildContext context) {
    return Container(
      child: Row(
       // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[
          Expanded(
            child: dobField(context),
            flex: 3,
          ),
          Expanded(child: SizedBox(),flex: 1,),
          Expanded(
            child: genderWidget(),
            flex: 3,
          )
        ],
      ),
    );
  }
}
