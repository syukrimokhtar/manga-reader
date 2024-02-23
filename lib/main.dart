import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader/config/app.dart';
import 'package:manga_reader/config/config.dart';
import 'package:manga_reader/library/sm.dart';

void main() {

  runZonedGuarded(() async {

    BindingBase.debugZoneErrorsAreFatal = true;
    WidgetsFlutterBinding.ensureInitialized();

    await Sm.init(appConfig, () {

      runApp(const App());

    });

  },
  (error, stack) => Sm.handleError(error, stack));

  
}