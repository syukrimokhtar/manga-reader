import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_reader/library/sm_layout.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  
  const ImageView({Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _imageViewState();
}

class _imageViewState extends State<ImageView> {

  @override
  Widget build(BuildContext context) {

    var args = Get.arguments;
    var title = Text("${args['title']}");
    var imageUrl = args['imageUrl'];

    Widget body = RawGestureDetector(
      gestures: {
    PanGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
          () => PanGestureRecognizer(
            allowedButtonsFilter: (buttons) => buttons == kSecondaryButton,
          ),
          (instance) {
            /// Add your event handlers here.
            instance
              ..onDown = (details) {
                Get.back();
              }
              ..onUpdate = (details) {
                //print("onUpdate: $details");
              };
          },
        ),
      },
      child: PhotoView(
        disableGestures: false,
        imageProvider: NetworkImage(imageUrl)));
    return SmLayout(
      title: title,
      body: body,
      back: () {
        Get.back();
      });
  }
}