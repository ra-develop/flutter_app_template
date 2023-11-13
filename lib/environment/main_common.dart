import 'dart:io';

import 'package:app_template/core/data/datasources/data_base/object_box_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/domain/providers/object_box_service_provider.dart';
import '../core/services/observers.dart';
import '../core/services/storage/remote/certificate_verify_resolve.dart';
import '../main.mapper.g.dart';
import 'app.dart';
import 'config/config.dart';

Future<void> mainCommon({required Flavor flavorConfiguration}) async {
  // Equatable can implement toString method including all the given props.
  // If stringify is overridden for a specific Equatable class,
  // then the value of EquatableConfig.stringify is ignored.
  // In other words, the local configuration always takes precedence
  // over the global configuration.
  // Note: EquatableConfig.stringify defaults to true in debug mode and
  // false in release mode.
  // EquatableConfig.stringify = true;

  // To initiate JsonMapper and to use the annotation @jsonSerializable
  // run the code generation step with the root of your package
  // as the current directory:
  // $ dart run build_runner build --delete-conflicting-outputs
  // You'll need to re-run code generation each time you are making
  // changes to lib/main.dart So for development time, use watch like this:
  // $ dart run build_runner watch --delete-conflicting-outputs
  initializeJsonMapper();

  // For resolve fails CERTIFICATE_VERIFY_FAILED for HTTPS site with no certificate
  HttpOverrides.global = CertificateVerifyResolve();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initiating the Config
  await Config(flavorConfiguration).initializationDone;

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.light.copyWith(
  //     statusBarColor: Colors.black,
  //     statusBarBrightness: Brightness.light,
  //   ),
  // );

  // Initiating the Local Data Base
  final objectBoxService = ObjectBoxService();
  await objectBoxService.init();

  // Start App
  runApp(ProviderScope(
    observers: [
      Observers(),
    ],
    overrides: [
      objectboxServiceProvider.overrideWithValue(objectBoxService),
    ],
    child: const App(),
  ));
}
