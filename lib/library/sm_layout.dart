import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manga_reader/controllers/home_controller.dart';

class SmLayout extends GetView<HomeController> {

  late Widget body;
  late Widget? title;
  late Function? back;
  late List<Widget>? actions;
  late FloatingActionButton? floatingActionButton;
  final HomeController _homeController = Get.find();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  SmLayout({
    required
    this.body,
    this.title,
    this.back,
    this.actions,
    this.floatingActionButton});

  Widget? _title(Widget? title) {
    if(title == null) {
      return null;
    }
    return title;
  }

  PreferredSizeWidget _appBar({
      Widget? title,
      List<Widget>? actions,
    Function? back}) {
    return AppBar(
      title: _title(title),
      actions: actions,
      leading: back == null ?
        //menu
        IconButton(onPressed: () {

          if(scaffoldKey.currentState!.isDrawerOpen){
            scaffoldKey.currentState!.closeDrawer();
          }else{
            scaffoldKey.currentState!.openDrawer();
          }

        }, icon: const Icon(Icons.menu)) :
        //back
        IconButton(onPressed: () {
          back();
        }, icon: const Icon(Icons.arrow_back)),
      backgroundColor: Colors.transparent);
  }

  Widget _drawer() {

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero)
      ),
      child: Obx(() {

        List<Widget> chapterList = [];

        //home
        chapterList.add(ListTile(
          title: Text("Home", style: TextStyle(
            fontWeight: _homeController.selected.value == 'home' ?
            FontWeight.bold : FontWeight.normal)),
          leading: const Icon(Icons.home),
          onTap: () {
            scaffoldKey.currentState!.closeDrawer();
            _homeController.clear();
            _homeController.selected("home");
            
          }));

        //chapters
        var chapters = _homeController.chapterList;
        for(var chapter in chapters) {
          var title = chapter['title'];
          var url = chapter['url'];
          
          chapterList.add(ListTile(
            title: Text(title, style: TextStyle(
              fontWeight:
                _homeController.selected.value == url ?
                FontWeight.bold : FontWeight.normal)),
            onTap: () {
              scaffoldKey.currentState!.closeDrawer();
              _homeController.selected(url);
              _homeController.fetchChapter(url, title);
            },
          ));
        }

        return ListView(
          children: chapterList,
        );
        
      }));

  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      body: body,
      floatingActionButton: floatingActionButton,
      appBar: _appBar(
        title: title,
        back: back,
        actions: actions),
      drawer: _drawer()
    );

  }
}