import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_weather/data/api_servic/wheather_api_service.dart';

import 'package:dio/dio.dart';
import 'package:flutter_weather/data/model/city_model.dart';
import 'package:flutter_weather/data/model/weather_model.dart';

class WeatherRepository {
  late Dio _dio;
  late WeatherApiService _weatherApiService;
  final Options _options = buildCacheOptions(
    const Duration(days: 1),
    forceRefresh: true,
  );
  WeatherRepository() {
    _dio = Dio();
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        logPrint: ((object) {
          // print(object);
        }),
      ),
    );
    _dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
    _weatherApiService = WeatherApiService(_dio);
  }
  Future<List<CityModel>> searchCity({required String city}) {
    return _weatherApiService.searchCity(city: city,options: _options);
  }

  Future<WeatherModel> getWeatherInfo({required String cityId}) {
    return _weatherApiService.getWeatherInfo(cityId: cityId,options: _options);
  }
}
