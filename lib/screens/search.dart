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
    return Container(
      padding: EdgeInsets.only(left: 2.0, top: 10.0, bottom: 5.0,),
      child: ListTile(
        leading: Icon(iconList[index]),
        title: Text(
          searchOptions[index],
          style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(
              width: 2.0,
              color: Colors.white
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Search"),
      body: Container(
        child: ListView.builder(
          itemCount: iconList.length,
          itemBuilder: (context, index) {
            return singleTile(index);
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(context: context, index: 1)
    );
  }
}
