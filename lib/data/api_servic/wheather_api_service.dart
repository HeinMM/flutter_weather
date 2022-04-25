import 'package:flutter_weather/const/const.dart';
import 'package:flutter_weather/data/model/city_model.dart';
import 'package:flutter_weather/data/model/weather_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'wheather_api_service.g.dart';

@RestApi(baseUrl: Const.BASE_URL)
abstract class WeatherApiService {
  factory WeatherApiService(Dio _dio) => _WeatherApiService(_dio);

  @GET("/location/search/")
  Future<List<CityModel>> searchCity({@Query("query") required String city, @DioOptions() required options});

  @GET("location/{cityId}")
  Future<WeatherModel> getWeatherInfo({@Path("cityId") required String cityId, @DioOptions() required options});
}
