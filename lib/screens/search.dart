import 'package:flutter/material.dart';
import 'package:medicaid/utils/utils.dart';

class Search extends StatefulWidget {

  static const String routeName = "/search";

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  static final activeRouteLinkColor = 0XFFB4BDFB;

  var iconList = [Icons.av_timer,Icons.supervisor_account, Icons.account_balance, Icons.local_hospital, Icons.monetization_on, Icons.attach_money, ];
  var searchOptions = ["Urgent Care", "Providers", "Places", "Pharmacies", "Estimated Care Cost", "Estimated Drug Cost"];

  Widget singleTile(int index) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
        padding: EdgeInsets.only(left: 2.0, top: 10.0, bottom: 5.0,),
        child: ListTile(
          leading: Container(
            decoration: ShapeDecoration(
                color: Color(0XFF00AFDF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                )
            ),
            padding: EdgeInsets.all(10.0),
            child: Icon(iconList[index], color: Colors.white,),
          ),
          title: Text(
            searchOptions[index],
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Search"),
      body: Container(
        color: Color(0XFFF3F3F3),
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
        child: ListView.builder(
          itemCount: iconList.length,
          itemBuilder: (context, index) {
            return singleTile(index);
          },
        ),
      ),
      bottomNavigationBar: BaseTheme(
        context: context,
        navigation: CustomBottomNavigation(context: context, index: 1),
      )
    );
  }
}
