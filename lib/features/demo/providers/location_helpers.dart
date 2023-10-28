import 'dart:developer' as developer;

import 'package:app_template/features/demo/data/demo_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

const String _kLocationServicesDisabledMessage =
    'Location services are disabled.';
const String _kPermissionDeniedMessage = 'Permission denied.';
const String _kPermissionDeniedForeverMessage = 'Permission denied forever.';
const String _kPermissionGrantedMessage = 'Permission granted.';

final positionProvider = FutureProvider<Position>((ref) async {
  await handleLocationPermission();
  final position = await updateCurrentPosition();
  return position;
});

Future<Position> updateCurrentPosition() async {
  final position = await Geolocator.getCurrentPosition(
      timeLimit: const Duration(seconds: 60),
      desiredAccuracy: LocationAccuracy.reduced,
      forceAndroidLocationManager: false);
  DemoConfig.lastKnownPosition = position;
  return position;
}

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    logPositionHandlers(
      _kLocationServicesDisabledMessage,
    );

    return false;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      logPositionHandlers(
        _kPermissionDeniedMessage,
      );

      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    logPositionHandlers(
      _kPermissionDeniedForeverMessage,
    );

    return false;
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  logPositionHandlers(
    _kPermissionGrantedMessage,
  );
  return true;
}

logPositionHandlers(String message) {
  developer.log(message, name: "geolocation:");
}
