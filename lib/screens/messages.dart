import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';

class Messages extends StatefulWidget {

  static const String routeName = "/messages";

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  static final activeRouteLinkColor = 0XFFB4BDFB;

  Widget messageTile ({@required String heading, String time, String body}) {
    return Container(
      child: ListTile(
        onTap: null,
        leading: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.purple,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.games, color: Colors.white),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 5.0,),
            Text(
              heading,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 12.0
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
      decoration: BoxDecoration(
          border: Border.all(
              width: 2.0,
              color: Color(0XFFF8F9FF)
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF8F9FF),
      appBar: CustomAppBar(title: "Messages"),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return messageTile(
                heading: "Health Plan",
                time: "9/27/18 6:54 PM",
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
