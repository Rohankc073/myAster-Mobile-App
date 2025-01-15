import 'package:flutter/material.dart';
import 'package:myasteer/app/app.dart';
import 'package:myasteer/app/di/di.dart';
import 'package:myasteer/core/network/hive_service.dart';

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
