import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../data/CurrentWeatherData.dart';
import '../data/demo_config.dart';
import '../services/network/dio_helpers.dart';
import 'get_current_weather_data.dart';

Future<CurrentWeatherData> getCurrentWeatherDataApi(
    {GetCurrentWeatherDataArgs? getCurrentWeatherDataArgs}) async {
  final dio = Dio(dioBaseOptions());
  late final dynamic response;
  Map<String, dynamic> queryParameters = {
    'lat': getCurrentWeatherDataArgs?.latitude ??
        DemoConfig.lastKnownPosition?.latitude,
    'lon': getCurrentWeatherDataArgs?.longitude ??
        DemoConfig.lastKnownPosition?.longitude,
    'units': DemoConfig.units.name,
    'appid': DemoConfig.accessToken,
  };
  try {
    response =
        await dio.post('/data/2.5/weather', queryParameters: queryParameters);
  } on DioException catch (e) {
    dioErrorHandler(e, moduleName: "getCurrentWeatherDataApi");
    // rethrow;
    throw Exception("Access to CMS: ${e.message}");
  }
  CurrentWeatherData results = CurrentWeatherData();
  final json = response.data;
  try {
    results = CurrentWeatherData.fromJson(json);
  } catch (error) {
    developer.log("Error is $error", name: "getCurrentWeatherDataApi");
    throw Exception("Access to CMS: $error");
    // rethrow;
  }
  return results;
}
