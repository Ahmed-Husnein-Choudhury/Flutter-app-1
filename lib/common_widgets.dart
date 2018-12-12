import 'package:flutter/material.dart';

class CommonWidgets {


  static Widget logo() {
    return Center(
      child: Image.asset(
        "assets/logo.jpg",
        height: 100.0,
      ),
    );
  }

  static Widget spacer({@required double gapHeight}) {
    return SizedBox(
      height: gapHeight,
    );
  }
}
