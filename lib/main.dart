import 'package:flutter/material.dart';
import 'package:myAster/app/app.dart';
import 'package:myAster/app/di/di.dart';
import 'package:myAster/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive Database
  await HiveService.init();

  // Delete all the hive data and boxes
  // await HiveService().clearAll();
  // Initialize Dependencies
  await initDependencies();

  runApp(
    const App(),
  );
}
