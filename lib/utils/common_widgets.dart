import 'package:flutter/material.dart';

class CommonWidgets {

  static const cardBackGroundColor = 0XFFFCF9FF;
  static const directCallColor = Colors.lightGreen;
  static const callNowColor = Colors.purple;
  static const callLaterColor = Colors.grey;


  static Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.png",
        height: 100.0,
      ),
    );
  }

  static Widget spacer({@required double gapHeight}) {
    return SizedBox(
      height: gapHeight,
    );
  }

  static Widget showErrorAlertDialog({@required BuildContext context,
    @required String title, @required String content, @required String confirmationText, double height}) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
            title: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    title,
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
              height: height != null ? height : 180.0,
              child: Column(
                children: <Widget>[
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0),
                  ),
                  CommonWidgets.spacer(gapHeight: 25.0),
                  RaisedButton(
                      color: Color(0XFF00AFDF),
                      shape: StadiumBorder(
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0XFF00AFDF),
                        ),
                      ),
                      child: Text(
                          confirmationText,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                          )
                      ),
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

  static Widget showSuccessAlertDialog({@required BuildContext context,
    @required String title, @required String content, @required String confirmationText, double height}) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            title: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    title,
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
              height: height != null ? height : 180.0,
              child: Column(
                children: <Widget>[
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0),
                  ),
                  CommonWidgets.spacer(gapHeight: 25.0),
                  RaisedButton(
                      color: Color(0XFF00AFDF),
                      shape: StadiumBorder(
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0XFF00AFDF),
                        ),
                      ),
                      child: Text(
                          confirmationText,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                          )
                      ),
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

  static Widget showDefaultAlertDialog({@required BuildContext context,
    @required String title, @required String content, @required String confirmationText, double height}) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            title: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
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
              height: height != null ? height : 180.0,
              child: Column(
                children: <Widget>[
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0),
                  ),
                  CommonWidgets.spacer(gapHeight: 25.0),
                  RaisedButton(
                      color: Color(0XFF00AFDF),
                      shape: StadiumBorder(
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0XFF00AFDF),
                        ),
                      ),
                      child: Text(
                          confirmationText,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                          )
                      ),
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

  static Widget callOption({@required String primaryText, String optionalText, @required Color color}) {
    return SizedBox(
        height: 80.0,
        child: Container(
          color: Color(0XFFF3F3F3),
          padding: EdgeInsets.only(left: 40.0, top: 5.0, bottom: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  maxRadius: 5.0,
                  child: Icon(Icons.call),
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(primaryText, style: TextStyle(color: Color(0XFF6A6A6A), fontSize: 15.0),),
                      optionalText != null ? Text(optionalText,  style: TextStyle(color: Color(0XFF6A6A6A), fontSize: 15.0),) : Center()
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  static Widget boxDivider (@required double height) {
    return Divider(
      height: height,
    );
  }

}
