import 'package:e_shop/app.dart';
import 'package:e_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:e_shop/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  //Widget Binding
  final WidgetsBinding widgetBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //initialise Getx Local Storage
  await GetStorage.init();

  //await splash screen until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

//Initialise Firebase And Authentiaction Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  //run ourapp
  runApp(const App());
}
