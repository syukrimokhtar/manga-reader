import 'package:get/get.dart';
import 'package:manga_reader/controllers/home_controller.dart';
import 'package:manga_reader/pages/Home/home.dart';
import 'package:manga_reader/pages/ImageView/image_view.dart';

smRoutes() => [

  //
  // Home
  //
  GetPage(
    name: '/home',
    page: () => Home(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<HomeController>(() => HomeController());
      
    }),
    transition: Transition.cupertinoDialog
  ),

  //
  // View
  //
  GetPage(
    name: '/imageView',
    page: () => ImageView(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<HomeController>(() => HomeController());
      
    }),
    transition: Transition.cupertinoDialog
  ),


];