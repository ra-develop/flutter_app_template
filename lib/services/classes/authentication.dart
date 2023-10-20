import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config.dart';

final authenticationServiceProvider =
    ChangeNotifierProvider<AuthenticationService>((ref) {
  return AuthenticationService();
});

// Thanks to Robert Brunhage
// https://github.com/RobertBrunhage/flutter_firebase_auth_tutorial
class AuthenticationService extends ChangeNotifier {
  AuthenticationService() {
    initUserToken();
  }

  String _accessToken = "";

  String get accessToken => _accessToken;

  set accessToken(String value) {
    _accessToken = value;
    notifyListeners();
  }

  Future<void> initUserToken() async {
    accessToken = Config.getTokenAPI;
  }
}
