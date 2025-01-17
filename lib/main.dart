import 'package:flutter/cupertino.dart';
import 'package:sprint_1/app/app.dart';
import 'package:sprint_1/app/di/di.dart';
import 'package:sprint_1/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  await initDependencies();
  runApp(
    App(),
  );
}
