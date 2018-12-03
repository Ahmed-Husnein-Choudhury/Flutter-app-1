import 'package:flutter/material.dart';
//import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class MemberRegistration extends StatefulWidget {

  // defining the route here
  static final String routeName = "/memberRegistration";

  @override
  _MemberRegistrationState createState() => _MemberRegistrationState();
}

class _MemberRegistrationState extends State<MemberRegistration> {

  DateTime _date = new DateTime.now();
  String _gender;
  List<String> _genderOptions = new List<String>();

  String memberId, dateOfBirth, firstName, lastName, gender, email, confirmEmail, mobileNumber;

  // member id controller
  final memberIdController = TextEditingController();

  // date of birth controller
  final dobController = TextEditingController();

  // first name controller
  final firstNameController = TextEditingController();

  // last name controller
  final lastNameController = TextEditingController();

  // gender controller
  final genderController = TextEditingController();

  // email controller
  final emailController = TextEditingController();

  // confirm email controller
  final confirmEmailController = TextEditingController();

  // mobile number controller
  final mobileNumberController = TextEditingController();


  @override
  void initState() {
    _genderOptions.addAll(["--Select a gender--","Male", "Female"]);
    _gender = _genderOptions.elementAt(0);
  }

  @override
  void dispose() {
    memberIdController.dispose();
    dobController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    genderController.dispose();
    emailController.dispose();
    confirmEmailController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  // method to check whether the email and the confirm email is same or not
  bool isEmailMatched(String email, String confirmEmail) {
    if (email == confirmEmail) {
      return true;
    }
    return false;
  }

  void saveMemberInfo() {
    this.memberId = memberIdController.text;
    this.dateOfBirth = dobController.text;
    this.firstName = firstNameController.text;
    this.lastName = lastNameController.text;
    this.gender = genderController.text;
    this.email = emailController.text.toLowerCase();
    this.confirmEmail = confirmEmailController.text.toLowerCase();
    this.mobileNumber = mobileNumberController.text;

    print("Member ID: $memberId");
    print("DOB : $dateOfBirth");
    print("First Name: $firstName");
    print("Last Name: $lastName");
    print("Gender: $_gender");
    print("Email: $email");
    print("Confirm Email: $confirmEmail");
    print("Mobile NO: $mobileNumber");

    // matching the given email and confirm email here
    if (this.isEmailMatched(email.toLowerCase(), confirmEmail.toLowerCase())) {
      print("both are matched");
    } else {
      print("both are mismatched");
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
    return TextField(
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
      child: TextField(
        controller: memberIdController,
        decoration: InputDecoration(
          labelText: "Member ID/Medicaid ID*",
          /*border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            borderSide: BorderSide(
              width: 1.0
            )
          )*/
        ),
      ),
    );
  }

  // first name widget
  Widget firstNameField() {
    return TextField(
      controller: firstNameController,
      decoration: InputDecoration(
          labelText: "First name*"
      ),
    );
  }

  // last name widget
  Widget lastNameField() {
    return TextField(
      controller: lastNameController,
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
      print(gender);
      this._gender = gender;
    });
  }

  // gender widget
  Widget genderWidget () {
    return Container(
      width: 300.0,
      child: DropdownButton(
        value: _gender,
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
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
          labelText: "Email Address*"
      ),
    );
  }

  // confirm email widget
  Widget confirmEmailField() {
    return TextField(
      controller: confirmEmailController,
      decoration: InputDecoration(
          labelText: "Confirm Email Address*"
      ),
    );
  }

  // Mobile number widget
  Widget mobileNumberField() {
    return TextField(
      controller: mobileNumberController,
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
      ),
    );
  }
}
