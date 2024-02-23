import 'package:flutter/material.dart';
import 'package:manga_reader/library/sm.dart';

class App extends StatelessWidget {

  const App({super.key});

  
  @override
  Widget build(BuildContext context) {

    return Sm.instance.createMaterialApp(context);

  }

}