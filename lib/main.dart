import 'dart:async';
import 'package:flutter/material.dart';

import 'package:stackoverflow_users_app/core/bootstrap/bootstrap.dart';
import 'package:stackoverflow_users_app/my_app.dart';

Future<void> main() async {
  // Catch uncaught async errors (e.g., from isolates)
  runZonedGuarded(() async {
    FlutterError.onError = (details) {
      FlutterError.dumpErrorToConsole(details);
      // TODO(next-enhancement): send to crash reporter if needed
    };

    await bootstrap();
    runApp(const MyApp());
  }, (error, stack) {
    // TODO(next-enhancement): send to crash reporter
  });
}
