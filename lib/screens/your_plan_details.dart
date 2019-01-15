import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:medicaid/utils/utils.dart';

class YourPlanDetails extends StatefulWidget {

  static final String routeName = "/planDetails";

  @override
  _State createState() => new _State();
}

class _State extends State<YourPlanDetails> {
  final String GREEN_COLOR = "#9ED151";
  final String FOR_CARE_ON = "For care on September 18, 2018";
  final String startDate = "January 1, 2019";
  final String endDate = "December 31st, 2019";
  final String firstName = "Ben";
  final String lastName = "Hoefs";
  final double copay = 100.00;
  final double deductible = 500.00;
  final double outOfPocketMax = 1000.00;

  double getCopayPercentage(double copay) {
    double tempValue = copay / 200;
    return tempValue;
  }

  double getDeductiblePercentage(double deductible) {
    double tempValue = deductible / 500;
    return tempValue;
  }

  double getOutOfPocketMaxPercentage(double outOfPocketMax) {
    double tempValue = outOfPocketMax / 1500;
    return tempValue;
  }

  @override
  Widget build(BuildContext context) {

    var copayWidget = new LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * 0.85,
      animation: true,
      animationDuration: 2000,
      lineHeight: 30.0,
      percent: getCopayPercentage(copay),
      center: Text("\$${copay.toStringAsFixed(2)} out of \$200.00",style: TextStyle(color: Colors.white),),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor:  Color(0XFF00AFDF),
      backgroundColor: Color(0XFFD4D4D4),
    );

    var deductibleWidget = new LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * 0.85,
      animation: true,
      animationDuration: 2000,
      lineHeight: 30.0,
      percent: getDeductiblePercentage(deductible),
      center: Text("\$${deductible.toStringAsFixed(2)} out of \$500.00",style: TextStyle(color: Colors.white),),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor:  Color(0XFF1EE3B7),
      backgroundColor: Color(0XFFD4D4D4),
    );

    var outOfPocketMaxWidget = new LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * 0.85,
      animation: true,
      animationDuration: 2000,
      lineHeight: 30.0,
      percent: getOutOfPocketMaxPercentage(outOfPocketMax),
      center: Text("\$${outOfPocketMax.toStringAsFixed(2)} out of \$1500.00",style: TextStyle(color: Colors.white),),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor:  Color(0XFF00AFDF),
      backgroundColor: Color(0XFFD4D4D4),

    );

    return new Scaffold(
            appBar: CustomAppBar(title: "Your Plan Details"),
            body: Container(
              color: Color(0XFFF3F3F3),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: new Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 10.0),
                    child: new Center(
                        child: new Container(
                          child: new Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Eligible",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color:  Color(0XFF00AFDF),
                                  )),
                              new Padding(padding: EdgeInsets.only(top: 15.0)),
                              new Text(
                                FOR_CARE_ON,
                                style:
                                TextStyle(fontSize: 15.0, color: Colors.black54),
                              ),
                              new Padding(padding: EdgeInsets.only(top: 15.0)),
                              new Stack(
                                children: <Widget>[
                                  new Align(
                                    alignment: Alignment.centerLeft,
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: <Widget>[
                                        new Text(
                                          "Start Date",
                                          style: TextStyle(color:  Color(0XFF1676B3)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                        ),
                                        new Text(
                                          startDate,
                                          style: TextStyle(fontSize: 15.0, color: Color(0XFF6A6A6A)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Align(
                                      alignment: AlignmentDirectional.bottomCenter,
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: new Text(
                                            "-",
                                            style: TextStyle(
                                                fontSize: 45.0, color: Colors.black54),
                                          )),
                                  ),
                                  new Align(
                                    alignment: Alignment.centerRight,
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: <Widget>[
                                        new Text("End Date",
                                            style:
                                            TextStyle(color:  Color(0XFF1676B3))),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                        ),
                                        new Text(endDate,
                                            style: TextStyle(fontSize: 15.0, color: Color(0XFF6A6A6A)))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              new Padding(padding: EdgeInsets.only(top: 10.0)),
                              new Text(
                                "Coverage-Medical",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color:  Color(0XFF00AFDF),
                                  ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 15.0)),

                              new Stack(
                                children: <Widget>[
                                  new Align(
                                    alignment: Alignment.centerLeft,
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: <Widget>[
                                        new Text(
                                          "Patient First Name",
                                          style: TextStyle(
                                            color:  Color(0XFFD4D4D4),
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 5.0)),
                                        new Text(
                                          firstName,
                                          style: TextStyle(
                                            color:  Color(0XFF6A6A6A),
                                            fontSize: 16.0
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Align(
                                    alignment: Alignment.centerRight,
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: <Widget>[
                                        new Text(
                                          "Patient Last Name",
                                          style: TextStyle(
                                            color:  Color(0XFFD4D4D4),
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 5.0)),
                                        new Text(
                                          lastName,
                                          style: TextStyle(
                                              color:  Color(0XFF6A6A6A),
                                              fontSize: 16.0
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Padding(padding: EdgeInsets.only(top: 30.0)),

                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                child: new Stack(
                                  children: <Widget>[
                                    new Align(
                                        alignment: Alignment.centerLeft,
                                        child: new Text("Copay", style: TextStyle(color: Color(0XFF6A6A6A), fontSize: 14.0),)),
                                    new Align(
                                      alignment: Alignment.centerRight,
                                      child: new Text("\$100.00 to go",style: TextStyle(color: Color(0XFF6A6A6A))),
                                    )
                                  ],
                                ),
                              ),
                              copayWidget,
                              // ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                child: new Stack(
                                  children: <Widget>[
                                    new Align(
                                        alignment: Alignment.centerLeft,
                                        child: new Text("Deductible", style: TextStyle(color: Color(0XFF6A6A6A)))),
                                    new Align(
                                      alignment: Alignment.centerRight,
                                      child: new Text("\$0.00 to go", style: TextStyle(color: Color(0XFF6A6A6A))),
                                    )
                                  ],
                                ),
                              ),
                              deductibleWidget,
                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                child: new Stack(
                                  children: <Widget>[
                                    new Align(
                                        alignment: Alignment.centerLeft,
                                        child: new Text("Out of Pocket Max",style: TextStyle(color: Color(0XFF6A6A6A)))),
                                    new Align(
                                      alignment: Alignment.centerRight,
                                      child: new Text("\$500.00 to go", style: TextStyle(color: Color(0XFF6A6A6A))),
                                    )
                                  ],
                                ),
                              ),

                              outOfPocketMaxWidget,
                              //flex: 1,
                            ],
                          ),
                        )),
                  )
              ),
            ),
          bottomNavigationBar: BaseTheme(
            context: context,
            navigation: CustomBottomNavigation(context: context, index: 4),
          )

    );
  }
}
