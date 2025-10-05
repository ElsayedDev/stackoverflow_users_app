import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Optional:
  /// Lock device orientations if you want
  ///
  // await SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );

  await Hive.initFlutter(); // Only framework-level init here
  await initServiceLocator(); // Register singletons + open Hive boxes here if you do that inside DI

  await dotenv.load();
}
