import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';
import 'package:medicaid/utils/common_widgets.dart';

class Contact extends StatefulWidget {

  static const String routeName = "/contact";

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  static final activeRouteLinkColor = 0XFFB4BDFB;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Contact"),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30.0),
          child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CommonWidgets.spacer(gapHeight: 50.0),
                  Text("How would you like to contact us?"),
                  CommonWidgets.spacer(gapHeight: 50.0),
                  CommonWidgets.callOption(
                    primaryText: "Call us directly",
                    optionalText: "888-555-1234",
                    color: Colors.lightGreen
                  ),
                  CommonWidgets.boxDivider(1.0),
                  CommonWidgets.callOption(
                    primaryText: "We can call you now",
                    color: Colors.purple
                  ),
                  CommonWidgets.boxDivider(1.0),
                  CommonWidgets.callOption(
                    primaryText: "We can call you later",
                    color: Colors.grey
                  ),
                  CommonWidgets.boxDivider(1.0),
                ],
              ),
          ),
        ),
      ),
      bottomNavigationBar: BaseTheme(
        context: context,
        navigation: CustomBottomNavigation(context: context, index: 3),
      ),
    );
  }
}
