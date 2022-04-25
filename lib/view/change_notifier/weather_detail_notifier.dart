import 'package:flutter/material.dart';
import 'package:flutter_weather/data/model/weather_model.dart';
import 'package:flutter_weather/data/weather_reposity.dart';

class WeatherDetailNotifier extends ChangeNotifier {
  final WeatherRepository _weatherRepository = WeatherRepository();
  bool loading = false;
  bool error = false;
  WeatherModel? weatherModel;
  double? _temp;
  void getWeatherInfo(String cityId) async {
    try {
      loading = true;
      notifyListeners();
      weatherModel = await _weatherRepository.getWeatherInfo(cityId: cityId);
      _temp = weatherModel!.consolidatedWeather![0].theTemp!;
      loading = false;
      notifyListeners();
    } catch (e) {
      error = true;
      loading = false;
      notifyListeners();
    }
  }

  double getTemp() {
    if (weatherModel != null) {
      return _temp!;
    } else {
      return 500;
    }
  }

  bgChangeColor(double tem) {
    loading = true;
    if (tem >= 30) {
      List<Color> color = [
        Color(0xffFFB74D),
        Color(0xffFF9800),
        Color(0xffFB8C00),
      ];
      loading = false;
      return color;
    } else if (tem < 30 && tem > 20) {
      loading = true;
      List<Color> color = [
        Color(0xffFFF59D),
        Color(0xffFFF176),
        Color(0xffFFEE58),
      ];
      loading = false;
      return color;
    } else if (tem < 20 && tem > 10) {
      loading = true;
      List<Color> color = [
        Color(0xffB2DFDB),
        Color(0xff80CBC4),
        Color(0xff4DB6AC),
      ];
      loading = false;
      return color;
    } else if (tem < 10 && tem > 0) {
      loading = true;
      List<Color> color = [
        Color(0xff42A5F5),
        Color(0xff42A5F5),
        Color(0xff42A5F5),
      ];
      loading = false;
      return color;
    } else if (tem < 0) {
      loading = true;
      List<Color> color = [
        Color(0xff1E88E5),
        Color(0xff1976D2),
        Color(0xff1565C0),
      ];
      loading = false;
      return color;
    } else {
       List<Color> color = [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 255, 255, 255),
      ];
      return color;
    }
  }

  String getImgUrl(String value, int index) {
    // String cond = weatherModel!.consolidatedWeather![index].weatherStateAbbr ?? "";
    if (value == "sn") {
      return "https://cdn-icons.flaticon.com/png/512/1409/premium/1409305.png?token=exp=1650713512~hmac=1a91203214a0f336030fbbd31241ceda";
    } else if (value == "sl") {
      return "https://cdn-icons-png.flaticon.com/512/2204/2204342.png";
    } else if (value == "h") {
      return "https://cdn-icons-png.flaticon.com/512/4165/4165590.png";
    } else if (value == "t") {
      return "https://cdn-icons-png.flaticon.com/512/1146/1146861.png";
    } else if (value == "hr") {
      return "https://cdn-icons-png.flaticon.com/512/3937/3937493.png";
    } else if (value == "lr") {
      return "https://cdn-icons.flaticon.com/png/512/1959/premium/1959351.png?token=exp=1650715767~hmac=26fbfc0661448dd0f1d875a8fdc61615";
    } else if (value == "s") {
      return "https://cdn-icons.flaticon.com/png/512/1959/premium/1959332.png?token=exp=1650715658~hmac=8b75220fdf593a2bf64914e93b145450";
    } else if (value == "hc") {
      return "https://cdn-icons-png.flaticon.com/512/1146/1146808.png";
    } else if (value == "lc") {
      return "https://cdn-icons.flaticon.com/png/512/4308/premium/4308600.png?token=exp=1650715285~hmac=71ea1f854dcc3cb7985fe364d548a708";
    } else if (value == "c") {
      return "https://cdn-icons-png.flaticon.com/512/826/826955.png";
    } else {
      return "https://cdn-icons.flaticon.com/png/512/1409/premium/1409305.png?token=exp=1650713512~hmac=1a91203214a0f336030fbbd31241ceda";
    }
  }
}
