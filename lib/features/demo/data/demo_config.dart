import 'package:app_template/environment/config/config.dart';
import 'package:geolocator/geolocator.dart';

import 'enumerators/unit_measure.dart';

class DemoConfig {
  // Used units of measurement
  static UnitMeasure units = UnitMeasure.metric;
  static Position? lastKnownPosition;

  static String get getBaseUrl {
    switch (Config.appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'https://api.openweathermap.org';
      case Flavor.STAGE:
        return 'https://api.openweathermap.org';
      case Flavor.PRODUCTION:
      default:
        return 'https://api.openweathermap.org';
    }
  }

  static String get accessToken {
    switch (Config.appFlavor) {
      case Flavor.DEVELOPMENT:
        return "ccf3cf8a6cae128209a01865ac8e1977";
      case Flavor.STAGE:
        return "ccf3cf8a6cae128209a01865ac8e1977";
      case Flavor.PRODUCTION:
      default:
        return "ccf3cf8a6cae128209a01865ac8e1977";
    }
  }
}
