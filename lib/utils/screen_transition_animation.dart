import 'package:flutter/material.dart';
import 'package:medicaid/screens/not_correct_location.dart';

class SlideRightRoute extends PageRouteBuilder {
//  final Widget widget;
  Function fun;
  String nextScreen;

  SlideRightRoute(this.nextScreen)
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
//    if(nextScreen=="Not Correct Location") return MyApp();
//    else if(nextScreen=="Your Plan Details")

      return NotCorrectLocation();

  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  });
}