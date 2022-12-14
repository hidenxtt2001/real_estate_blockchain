import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:real_estate_blockchain/config/app_config.dart';
import 'package:real_estate_blockchain/config/app_dialog.dart';
import 'package:real_estate_blockchain/config/app_notification.dart';
import 'package:real_estate_blockchain/injection_dependencies/injection_dependencies.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'feature/app/presentation/app_page.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.wait([
    AppConfig.instance.initialize(),
    configureDependencies(),
    AppNotification.instance.initialize(),
    Hive.initFlutter(),
  ]);

  runApp(const AppPage());
  FlutterNativeSplash.remove();
}
