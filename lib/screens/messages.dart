import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';

class Messages extends StatefulWidget {

  static const String routeName = "/messages";

  @override
  _MessagesState createState() => _MessagesState();
}


class _MessagesState extends State<Messages> {


  int timeInMinutes=2;

  static final activeRouteLinkColor = 0XFFB4BDFB;

  Widget messageTile ({@required String heading, String time, String body}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)
      ),
      color: Colors.white,
      child: Container(
        child: ListTile(
          onTap: null,
          leading: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0XFF00AFDF),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.textsms, color: Colors.white),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 5.0,),
              Text(
                heading,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    color: Color(0XFF6A6A6A)
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey
                ),
              )
            ],
          ),
          subtitle: Text(
            body,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0
            ),
          ),
          isThreeLine: true,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0XFFF8F9FF),
      appBar: CustomAppBar(title: "Messages"),
      body: Container(
        color: Color(0XFFF3F3F3),
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              timeInMinutes++;
              return messageTile(
                heading: "Health Plan",
                time: "9/27/18 6:5$timeInMinutes PM",
                body: "Checked in Mount Sinai"
              );
            }
        ),
      ),
      bottomNavigationBar: BaseTheme(
        context: context,
        navigation: CustomBottomNavigation(context: context, index: 2),
      ),
    );
  }
}
