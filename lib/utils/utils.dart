import 'package:flutter/material.dart';

import 'package:medicaid/screens/home_page.dart';
import 'package:medicaid/screens/contact.dart';
import 'package:medicaid/screens/messages.dart';
import 'package:medicaid/screens/search.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key key, @required String title}) : super(
    key: key,
    iconTheme: IconThemeData(
        color: Color(0XFF7F8EF9)
    ),
    title: Text(title, style: TextStyle(color: Color(0XFF7F8EF9), fontSize: 15.0)),
    backgroundColor: Color(0XFFF8F9FF),
    elevation: 0.5,
  );
}

class CustomBottomNavigation extends BottomNavigationBar {

  static final activeRouteLinkColor = 0XFF919EFA;

  CustomBottomNavigation({BuildContext context,@required int index})
      : super (
      currentIndex: (index > 0 && index < 4) ? index : 0,
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        } else if (index == 1) {
          Navigator.of(context).pushReplacementNamed(Search.routeName);
        } else if (index == 2) {
          Navigator.of(context).pushReplacementNamed(Messages.routeName);
        } else if (index == 3) {
          Navigator.of(context).pushReplacementNamed(Contact.routeName);
        }
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home, color: index == 0 ? Color(activeRouteLinkColor) : Color(0XFFCCCCCC),),
          title: new Text('Home', style: TextStyle(color: index == 0 ? Color(activeRouteLinkColor) : Color(0XFFCCCCCC))),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.search, color: index == 1 ? Color(activeRouteLinkColor) : Color(0XFFCCCCCC),),
          title: new Text('Search', style: TextStyle(color: index == 1 ? Color(activeRouteLinkColor) : Color(0XFFCCCCCC))),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.message, color: index == 2 ? Color(activeRouteLinkColor) : Color(0XFFCCCCCC),),
          title: new Text('Messages', style: TextStyle(color: index == 2 ? Color(activeRouteLinkColor) : Color(0XFFCCCCCC))),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.call, color: index == 3 ? Color(activeRouteLinkColor) : Color(0XFFCCCCCC),),
          title: new Text('Contacts', style: TextStyle(color: index == 3 ? Color(activeRouteLinkColor) : Color(0XFFCCCCCC))),
        ),
      ]
  );
}