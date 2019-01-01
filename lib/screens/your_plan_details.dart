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
  final String startDate = "January 1, 2018";
  final String endDate = "January 1, 2018";
  final String firstName = "Ben";
  final String lastName = "Hoefs";
  final double copay = 100.0;
  final double deductible = 400.0;
  final double outOfPocketMax = 1000.0;

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
      center: Text("\$${copay.toString()} out of \$200.00",style: TextStyle(color: Colors.white),),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.green[600],
      backgroundColor: Color(0XFF8785FF),
    );

    var deductibleWidget = new LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * 0.85,
      animation: true,
      animationDuration: 2000,
      lineHeight: 30.0,
      percent: getDeductiblePercentage(deductible),
      center: Text("\$${deductible.toString()} out of \$500.0",style: TextStyle(color: Colors.white),),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.green[600],
      backgroundColor: Color(0XFF8785FF),
    );

    var outOfPocketMaxWidget = new LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * 0.85,
      animation: true,
      animationDuration: 2000,
      lineHeight: 30.0,
      percent: getOutOfPocketMaxPercentage(outOfPocketMax),
      center: Text("\$${outOfPocketMax.toString()} out of \$1500.00",style: TextStyle(color: Colors.white),),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.green[600],
      backgroundColor: Color(0XFF8785FF),

    );

    return new Scaffold(
            appBar: CustomAppBar(title: "Your Plan Details"),
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: new Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 40.0, 15.0, 10.0),
                  child: new Center(
                      child: new Container(
                    child: new Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text("Eligible",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.green[600],
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
                                    style: TextStyle(color: Color(0XFF8785FF)),
                                  ),
                                  new Text(
                                    startDate,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
                            ),
                            new Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: new Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 45.0, color: Colors.black54),
                                )),
                            new Align(
                              alignment: Alignment.centerRight,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  new Text("End Date",
                                      style:
                                          TextStyle(color: Color(0XFF8785FF))),
                                  new Text(endDate,
                                      style: TextStyle(fontSize: 18.0))
                                ],
                              ),
                            ),
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 25.0)),
                        new Text(
                          "Coverage-Medical",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Padding(padding: EdgeInsets.only(top: 25.0)),

                        new Stack(
                          children: <Widget>[
                            new Align(
                              alignment: Alignment.centerLeft,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  new Text("Patient First Name"),
                                  new Text(firstName,style: TextStyle(fontSize: 18.0),),
                                ],
                              ),
                            ),
                            new Align(
                              alignment: Alignment.centerRight,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  new Text("Patient Last Name"),
                                  new Text(lastName,style: TextStyle(fontSize: 18.0))
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(padding: EdgeInsets.only(top: 30.0)),

                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: new Stack(
                            children: <Widget>[
                              new Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Text("Copay")),
                              new Align(
                                alignment: Alignment.centerRight,
                                child: new Text("\$200.00 to go"),
                              )
                            ],
                          ),
                        ),
                        copayWidget,
                        // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: new Stack(
                            children: <Widget>[
                              new Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Text("Deductible")),
                              new Align(
                                alignment: Alignment.centerRight,
                                child: new Text("\$500.00 to go"),
                              )
                            ],
                          ),
                        ),
                        deductibleWidget,
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: new Stack(
                            children: <Widget>[
                              new Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Text("Out of Pocket Max")),
                              new Align(
                                alignment: Alignment.centerRight,
                                child: new Text("\$1500.00 to go"),
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
          bottomNavigationBar: BaseTheme(
            context: context,
            navigation: CustomBottomNavigation(context: context, index: 4),
          )

    );
  }
}
