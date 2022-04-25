import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/data/model/city_model.dart';
import 'package:flutter_weather/data/weather_reposity.dart';

class CitySearchNotifier extends ChangeNotifier {
  late WeatherRepository _weatherRepository;
  late List<CityModel> cities;
  late bool error = false;
  late bool loading = false;
  CitySearchNotifier() {
    _weatherRepository = WeatherRepository();
    cities = [];
  }
  void searchCity({required String city}) async {
    try {
      loading = true;
      notifyListeners();
      cities = await _weatherRepository.searchCity(city: city);
      error = false;
      loading = false;
      notifyListeners();
    } catch (e) {
      error = true;
      loading = false;
      notifyListeners();
    }
  }
}
