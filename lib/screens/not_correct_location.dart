import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';

class NotCorrectLocation extends StatefulWidget {
  static final String routeName="/notCorrectLocation";
  static final appBarTextColor = 0XFF8785FF;

  @override
  _State createState() => new _State();
}

class _State extends State<NotCorrectLocation> {

  @override
  Widget build(BuildContext context) {
    Widget textView(String text) {
      return new Text(text,
          style: TextStyle(fontSize: 15.00, color: Colors.black54));
    }

    return new Screen();
  }
}

class Screen extends StatelessWidget {
  static final SORRY_WE_DID_NOT_GET_IT_RIGHT =
      "Sorry we did not get that right.";
  static final IN_ORDER_FOR_US_TO_PROVIDE =
      "Please enter your doctor's name below or hand your device to the practice staff member who can enter their unique NPI or TIN numbers";
  static final CANNOT_FIND_YOUR_PRACTICE =
      "If you can not find your practice, please call us to confirm your status at: 888-555-1234";

  Widget textView(String text) {
    return new Text(text,
        style: TextStyle(fontSize: 15.00, color: Colors.black54));
  }

  confirmInformation(){

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomAppBar(title: "Show Practice"),
      body: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Container(
            child: new Padding(
                padding: EdgeInsets.fromLTRB(28.01, 44.5, 51.99, 0.00),
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Text(
                      SORRY_WE_DID_NOT_GET_IT_RIGHT,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.00),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.00)),
                    textView(IN_ORDER_FOR_US_TO_PROVIDE),
                    new Padding(padding: EdgeInsets.only(top: 60.00)),
                    new TextField(
                      //style: ,
                      decoration:
                      InputDecoration(hintText: "Type Your Doctor's Name"),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.00)),
                    new TextField(
                      decoration: InputDecoration(
                          hintText: "Practice can add their NPI or TIN #"),
                    ),
//                    Container(
//                      width: (MediaQuery.of(context).size.width)*0.15,
                    //  new Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, (MediaQuery.of(context).size.width)*0.15, 0.0),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    // child:
                    RaisedButton(
                      onPressed:confirmInformation,
                      color: Color(0XFF00AFDF),
                      elevation:2.0 ,
                      child: Text(
                        "Confirm Information",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    //  ),
                    new Padding(padding: EdgeInsets.only(top: 60.00)),
                    textView(CANNOT_FIND_YOUR_PRACTICE),
                  ],
                )),
          )),
    );
  }
}
