import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_reader/controllers/home_controller.dart';
import 'package:manga_reader/library/device_size.dart';
import 'package:manga_reader/library/sm_layout.dart';

class Home extends GetView<HomeController> {

  final HomeController _homeController = Get.find();


  Widget _title() {
    return Obx(() => Text("${_homeController.title}"));
  }

  Widget _renderImage(DeviceSize deviceSize, List imageList) {

    if(imageList.isEmpty) {
      return SizedBox(
        height: deviceSize.height / 1.3,
        child: const Center(
          child: Text("not Available")));
    }

    List<Widget> childs = [];
    for(var imageUrl in imageList) {

      childs.add(
        GestureDetector(onTap: () {

          Get.toNamed("/imageView", arguments: {
            "imageUrl": imageUrl,
            "title": _homeController.title
          });
          
        }, child: Center(
          child: Image.network(imageUrl)))
      );
    }
    return Column(children: childs);

  }

  @override
  Widget build(context) {

    DeviceSize deviceSize = DeviceSize.create(context);

    Widget body = SingleChildScrollView(child:
      Stack(
        children: [

        Obx(() {
          if(_homeController.isLoading.isTrue) {

            return SizedBox(
              height: deviceSize.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator()));
          }

          return _renderImage(deviceSize, _homeController.imageList);
        })

      ]));

    return SmLayout(
      title: _title(),
      actions: [

        IconButton(icon: const Icon(Icons.refresh), onPressed: () {

          _homeController.fetchChapters();

        }).paddingOnly(right: 20)

      ],
      body: body);

  }

}