import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:medicaid/utils/common_widgets.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicaid/api_and_tokens/api_info.dart';
import 'package:medicaid/api_and_tokens/authentication_token.dart';

class CheckInVerificationCode extends StatelessWidget {

  static const String routeName = "/checkInVerificationCode";
  String receivedVerificationCode;
//
//  @override
//  _State createState() => new _State();
//
//}
//
//class _State extends State<CheckInVerificationCode>{
//
//  @override
//  initState(){
//    super.initState();
//
//  }

 Future<String> getVerificationCode() async {
   String url=ApiInfo.getBaseUrl();
   SharedPreferences pref=await SharedPreferences.getInstance();
   String memberId=pref.getString("member number");
    final response= await await get(url+"/api/v1/members/get_check_in_verification_code/$memberId",
    headers:{
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": AuthenticationToken.getToken()
    },
    );
   print("response from member verification code api:${response.body}");
   receivedVerificationCode=response.body;
   return receivedVerificationCode;
 }

  Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.png",
        height: 100.0,
      ),
    );
  }

  // defining the instructional text widget
  Widget instructionalText() {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
      child:Text(
      "Please show this page to the provider's office staff.",
      style: TextStyle(
        fontSize: 16.0,
      ),
    ));
  }

  // defining the health plan details text widget
  Widget healthPlanLabel() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Health Plan 1"),
          CommonWidgets.spacer(gapHeight: 5.0),
          RichText(text: TextSpan(style: TextStyle(fontSize: 14.0,height: 1.2),
              children: [
                TextSpan(text:"Customer Service ",style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: '(800) 555-2222',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () async {
                      String url = "tel:800555-2222";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else{
                        throw 'Could not launch $url';
                      }
                    }
                ),
              ]
          ))
        ],
      ),
    );
  }

  // defining the privacy text details text widget
  Widget bottomPrivacyTextLabel() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Your privacy is very important to us. We protect your personal health information as required by law."),
        ],
      ),
    );
  }

  Widget skipButton() {
    return Container(
      height: 50.0,
      width: 250.0,
      child: RaisedButton(
        color: Color(0XFF00AFDF),
        onPressed: null,
        child: Text(
          "Skip this step",
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

 Widget progressIndicator() {
   return Scaffold(
     body: Center(
       child: Container(
         child: Image(image: AssetImage("assets/loading_animation_03.gif")),
       ),
     ),
   );
 }

  Widget generateQRCode(){
    return QrImage(
      data:receivedVerificationCode,
          size:200.0
    );
  }
  
  Widget unableToAcceptCode(){
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
      child:Text("Is your provider unable to accept verification code?",
      style:TextStyle(fontSize: 16.0) ,)
    );
  }

  Widget verificationCode(){
   return Column(
     children: <Widget>[
              Align(
     alignment: Alignment.center,
     child:Text("Verification Code:") ,
   )  ,
              Align(
                alignment: Alignment.center,
                child:Text(receivedVerificationCode) ,
              )  ,
     ],
   );
  }

  Widget showVerificationCode(BuildContext context){
    return  Scaffold(
        appBar: CustomAppBar(title: "Check In",),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                logo(),
                CommonWidgets.spacer(gapHeight: 20.0),
                instructionalText(),
                CommonWidgets.spacer(gapHeight: 20.0),
                generateQRCode(),
                CommonWidgets.spacer(gapHeight: 20.0),
                verificationCode(),
                CommonWidgets.spacer(gapHeight: 30.0),
                unableToAcceptCode(),
                CommonWidgets.spacer(gapHeight: 20.0),
                skipButton(),
                CommonWidgets.spacer(gapHeight: 20.0),
                healthPlanLabel(),
                CommonWidgets.spacer(gapHeight: 20.0),
                bottomPrivacyTextLabel(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BaseTheme(
          context: context,
          navigation: CustomBottomNavigation(context: context, index: 4),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: getVerificationCode(),
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if(snapshot.hasData){
        if(receivedVerificationCode!=null){
          showVerificationCode(context);
        }
      }
      else return progressIndicator();
    },
    );
  }


}