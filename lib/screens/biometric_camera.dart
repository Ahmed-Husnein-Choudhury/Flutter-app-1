
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:medicaid/main.dart';
import 'package:path_provider/path_provider.dart';


class BiometricCamera extends StatefulWidget{
  @override
  _CameraState createState()=>_CameraState();

  static final String routeName = "/biometricCamera";

}


IconData getCameraLensIcon(CameraLensDirection direction) {
      return Icons.camera_front;
  }

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _CameraState extends State<BiometricCamera>{

  CameraController controller;
  String imagePath;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Camera example'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
          _captureControlRowWidget(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
               // RaisedButton(onPressed: _cameraTogglesRowWidget,child: Text("Open camera"),),
                _cameraTogglesRowWidget(),
                _thumbnailWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: imagePath == null
            ? null
            : SizedBox(
          child:
               Image.file(File(imagePath)),

          ),

        ),

    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
              controller.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
//    if(!cameras.isEmpty) {
//      onNewCameraSelected(CameraDescription(lensDirection: CameraLensDirection.front));
//    }
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
     // for (CameraDescription cameraDescription in cameras) {
       // cameraDescription=CameraDescription(lensDirection: CameraLensDirection.front);



//        toggles.add(
//          SizedBox(
//            width: 90.0,
//            child: RadioListTile<CameraDescription> (
//              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
//              groupValue: controller?.description,
//              value: cameraDescription,
//              onChanged: onNewCameraSelected,
//            ),
//          ),
//        );
    //  }
    }

    return RaisedButton(onPressed: (){frontCameraSelected(cameras[1]);},
      child: Text("Press"),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }



  void frontCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      print("controller disposing");
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    print("controller initialized");

    // If the controller is updated then update the UI.
    controller.addListener(() {
      print("listener in action");
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        print("controller Exception");

        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print("controller Exception");
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) showInSnackBar('Picture saved to $filePath');
      }
    });
  }


  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

}