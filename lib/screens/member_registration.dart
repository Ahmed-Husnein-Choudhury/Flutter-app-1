import 'package:flutter/material.dart';
//import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

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

  DateTime _date = new DateTime.now();
  List<String> _genderOptions = new List<String>();

  // form fields
  String memberId, dateOfBirth, firstName, lastName, gender, email, confirmEmail, mobileNumber;

  @override
  void initState() {
    _genderOptions.addAll(["--Select a gender--","Male", "Female"]);
    gender = _genderOptions.elementAt(0);
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
        print("both are matched");
      } else {
        print("both are mismatched");
      }

      print("Member ID: $memberId");
      print("DOB : $dateOfBirth");
      print("First Name: $firstName");
      print("Last Name: $lastName");
      print("Gender: $gender");
      print("Email: $email");
      print("Confirm Email: $confirmEmail");
      print("Mobile NO: $mobileNumber");
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(1950),
        lastDate: new DateTime(2018)
    );

    if (picked != null && picked != _date) {
      print("Date is: "+_date.toString());
      setState(() {
        _date = picked;
      });
    }
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

  // widget for choosing date of birth
  Widget dobField(BuildContext context) {
    return TextFormField(
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
  Widget memberIdField () {
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
      decoration: InputDecoration(
          labelText: "First name*"
      ),
    );
  }

  // last name widget
  Widget lastNameField() {
    return TextFormField(
      validator: validateLastName,
      onSaved: (String lastName) {
        this.lastName = lastName;
      },
      decoration: InputDecoration(
          labelText: "Last name*"
      ),
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
            child: SizedBox(
            ),
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
  Widget genderWidget () {
    return Container(
      width: 300.0,
      child: DropdownButton(
        value: this.gender,
        items: _genderOptions.map((String gender) {
          return DropdownMenuItem(
              value: gender,
              child: Text(""+gender)
          );
        }).toList(),
        onChanged: (String gender) {
          _setGender(gender);
        },
      )
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
      decoration: InputDecoration(
          labelText: "Email Address*"
      ),
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
      decoration: InputDecoration(
          labelText: "Confirm Email Address*"
      ),
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
      decoration: InputDecoration(
          labelText: "Mobile Number*"
      ),
    );
  }

  // defining the register button widget
  Widget confirmationButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: saveMemberInfo,
        child: Text(
          "Continue",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white
          ),
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
              dobField(context),
              spacer(gapHeight: 20.0),
              nameFieldRow(),
              spacer(gapHeight: 20.0),
              genderWidget(),
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
        )
      ),
    );
  }
}
