import 'package:flutter/material.dart';
import 'dart:io';
import 'package:medicaid/utils/common_widgets.dart';

class PhotoViewer extends StatefulWidget {

  // defining the route name here
  static final String routeName = "/photoViewer";
  final File imageFile;

  const PhotoViewer({this.imageFile});

  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {

  @override
  Widget build(BuildContext context) {
    CommonWidgets.showDefaultAlertDialog(context: context, title: "Success", content: "You are done", confirmationText: "Ok");
    return Container(
      child: Container(
        constraints: new BoxConstraints.expand(),
        child: widget.imageFile == null
            ? Text("not found")
        //? new Text("no image")
            : new Image.file(widget.imageFile),
      ),
    );
  }
}
