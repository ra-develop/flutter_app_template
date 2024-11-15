import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase/firebase_options.dart';

enum Flavor { DEVELOPMENT, STAGE, PRODUCTION }

class Config {
  late Future _doneFuture;
  static String defaultIcon = "assets/icons/winker_logo_fill.png";
  static Flavor appFlavor = Flavor.PRODUCTION;
  static late SharedPreferences appPreferences;
  static late bool loginStatus;
  static late int introPageIndex;
  static late bool firstStart;
  static late PackageInfo packageInfo;
  static late bool debug;
  static String USER_LOCAL_STORAGE_KEY = 'user';
  static bool kTestMode = Platform.environment.containsKey('FLUTTER_TEST');

  Config(Flavor flavor) {
    _doneFuture = _init(flavor);
  }

  Future get initializationDone => _doneFuture;

  Future<void> _init(Flavor flavor) async {
    Config.packageInfo = await PackageInfo.fromPlatform();

    // Setup Flavor
    Config.appFlavor = flavor;

    // Load App Preferences
    Config.appPreferences = await SharedPreferences.getInstance();

    // Check login status
    Config.loginStatus = Config.appPreferences.getBool("LoginStatus") ?? false;

    // Check first start status after install/reinstall
    Config.firstStart = Config.appPreferences.getBool("FirstStart") ?? false;

    // Which page of introduction was viewed
    Config.introPageIndex =
        Config.appPreferences.getInt('OnBoardPageIndex') ?? 0;

    //debug
    Config.debug = flavor == Flavor.DEVELOPMENT || flavor == Flavor.STAGE;

    //Firebase initialization
    final fireBaseOptions = DefaultFirebaseOptions.currentPlatform;
    if (fireBaseOptions.apiKey == '' ||
        fireBaseOptions.appId == '' ||
        fireBaseOptions.projectId == '') {
      developer.log("Firebase: FirebaseOptions did not set:",
          name: "Config init", error: fireBaseOptions.toString());
    } else {
      try {
        await Firebase.initializeApp(
          options: fireBaseOptions,
        );
        FlutterError.onError =
            FirebaseCrashlytics.instance.recordFlutterFatalError;
        developer.log("Firebase: initialization was successful",
            name: "Config init");
      } catch (e) {
        developer.log("Firebase: initialising error:",
            name: "Config init", error: e);
      }
    }
  }

  static String get getBaseUrl {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'https://dummyjson.com';
      case Flavor.STAGE:
        return 'https://dummyjson.com';
      case Flavor.PRODUCTION:
      default:
        return 'https://dummyjson.com';
    }
  }

  //For future implementation
  static String get getApiToken {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return "FAKE_API_TOKEN";
      case Flavor.STAGE:
        return "FAKE_API_TOKEN";
      case Flavor.PRODUCTION:
      default:
        return "FAKE_API_TOKEN";
    }
  }

  static String get loginPageTitle {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return "Login Page (PRODUCTION)";
      case Flavor.STAGE:
        return "Login Page (STAGE)";
      case Flavor.DEVELOPMENT:
      default:
        return "Login Page (DEVELOPMENT)";
    }
  }

  static String get demoPageTitle {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return "Demo Page (PRODUCTION)";
      case Flavor.STAGE:
        return "Demo Page (STAGE)";
      case Flavor.DEVELOPMENT:
      default:
        return "Demo Page (DEVELOPMENT)";
    }
  }

// For example of flavour configuration
/*  static Icon get someOneIcon {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return const Icon(Icons.new_releases);
      case Flavor.STAGE:
        return const Icon(Icons.new_releases_outlined);
      case Flavor.DEVELOPMENT:
      default:
        return const Icon(Icons.developer_mode);
    }
  }*/
}
