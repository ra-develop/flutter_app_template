import 'dart:io';

import 'package:flutter/material.dart';

import 'app.dart';
import 'services/core/config.dart';
import 'services/network/cms_helpers.dart';

Future<void> main() async {
  // For resolve fails CERTIFICATE_VERIFY_FAILED for HTTPS site with no certificate
  HttpOverrides.global = CertificateVerifyResolve();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initiating the Config
  await configInit(Flavor.DEVELOPMENT);

  // Start App
  runApp(const App());
}
