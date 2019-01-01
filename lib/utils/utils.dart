import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:medicaid/screens/home_page.dart';
import 'package:medicaid/screens/contact.dart';
import 'package:medicaid/screens/messages.dart';
import 'package:medicaid/screens/search.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key key, @required String title}) : super(
    key: key,
    iconTheme: IconThemeData(
      color: Color(0XFF00AFDF),
    ),
    title: Text(title, style: TextStyle(color: Color(0XFF00AFDF), fontSize: 15.0)),
    //backgroundColor: Color(0XFFF8F9FF),
    backgroundColor: Color(0XFFF3F3F3),
    elevation: 0.5,
  );
}

class BaseTheme extends Theme {
  BaseTheme({BuildContext context, @required CustomBottomNavigation navigation}) : super(
    data: Theme.of(context).copyWith(
        canvasColor: Color(0XFF30368A),
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Color(0XFF00AFDF)))),
    child: navigation
  );
}


class CustomBottomNavigation extends BottomNavigationBar {

  //static final activeRouteLinkColor = 0XFF919EFA;
  static final activeRouteLinkColor = Colors.white;

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
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home, color: index == 0 ? Colors.white : Color(0XFF00AFDF),),
          title: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              SizedBox(
                height: 4.0,
                child: Container(
                  color: Colors.white,
                  width: 50.0,
                  padding: EdgeInsets.only(top: 10.0),
                ),
              )
            ],
          )
          //title: new Text('Home', style: TextStyle(color: index == 0 ? Colors.white : Color(0XFF00AFDF),)),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.search, color: index == 1 ? activeRouteLinkColor : Color(0XFF00AFDF),),
          title: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              SizedBox(
                height: 4.0,
                child: Container(
                  color: Colors.white,
                  width: 50.0,
                  padding: EdgeInsets.only(top: 10.0),
                ),
              )
            ],
          )
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.message, color: index == 2 ? activeRouteLinkColor : Color(0XFF00AFDF),),
          title: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              SizedBox(
                height: 4.0,
                child: Container(
                  color: Colors.white,
                  width: 50.0,
                  padding: EdgeInsets.only(top: 10.0),
                ),
              )
            ],
          )
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.call, color: index == 3 ? activeRouteLinkColor : Color(0XFF00AFDF),),
          title: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              SizedBox(
                height: 4.0,
                child: Container(
                  color: Colors.white,
                  width: 50.0,
                  padding: EdgeInsets.only(top: 10.0),
                ),
              )
            ],
          )
        ),
      ]
  );
}

class CallOption {
  static void launchCaller()  async {
    String url = "tel:800555-2222";
    if (await canLaunch(url)) {
      await launch(url);
    } else{
      throw 'Could not launch $url';
    }

  }
}