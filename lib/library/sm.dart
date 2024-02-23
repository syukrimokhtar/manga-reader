import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_reader/config/middlewares.dart';
import 'package:manga_reader/config/routes.dart';
import 'package:manga_reader/library/sm_config.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Sm {

  static late Sm _instance;
  late Talker _talker;
  late SmConfig _config;

  static init(
      SmConfig smConfig,
      VoidCallback callback) async {

    _instance = Sm();
    _instance._config = smConfig;

    // Init Talker
    _instance._talker = TalkerFlutter.init();

    // Init GetStorage
    await GetStorage.init();
      
    // Init Dotenv
    await dotenv.load(fileName: ".env");

    callback();
    
  }


  /*
    handle error & stackTrace exception
  */
  static handleError(Object error, StackTrace stack) {
    final talker = Sm.instance.talker;
    talker.error(error);
    talker.handle(error, stack, 'Uncaught app exception');
  }

  /*
    Create MaterialApp
  */
  Widget createMaterialApp(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
          smartManagement: SmartManagement.onlyBuilder,
          routingCallback: smMiddlewares,
          debugShowCheckedModeBanner: false,
          initialRoute: Sm.instance.config.initialRoute,
          defaultTransition: Transition.leftToRightWithFade,
          theme: ThemeData(
            primaryColor: Sm.instance.config.primaryColor,
            colorScheme: const ColorScheme.light(
              background: Colors.white
            ),
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Sm.instance.config.primaryColor),
              foregroundColor: Sm.instance.config.primaryColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: GetPlatform.isAndroid ? Colors.transparent : Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              )),
            textTheme: GoogleFonts.getTextTheme(_config.defaultFont, textTheme)
          ),
          getPages: smRoutes());
  }

  //export function
  static Sm get instance => _instance;
  Talker get talker => _talker;
  SmConfig get config => _config;

}
