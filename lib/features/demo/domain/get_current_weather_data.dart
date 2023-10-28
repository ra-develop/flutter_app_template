import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/CurrentWeatherData.dart';
import 'get_current_weather_data_api.dart';

/// Get CurrentWeatherData Arguments
///
/// @param double? [latitude]
///
/// @param double? [longitude]
///

@jsonSerializable
class GetCurrentWeatherDataArgs extends Equatable {
  const GetCurrentWeatherDataArgs({
    this.latitude,
    this.longitude,
  });

  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}

final getCurrentWeatherDataProvider = FutureProvider.autoDispose
    .family<CurrentWeatherData, GetCurrentWeatherDataArgs>(
        (ref, getCurrentWeatherDataArgs) async {
  return await getCurrentWeatherDataApi(
      getCurrentWeatherDataArgs: getCurrentWeatherDataArgs);
});
