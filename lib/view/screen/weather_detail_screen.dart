import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/view/change_notifier/weather_detail_notifier.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WeatherDetailScreen extends StatefulWidget {
  final String title;
  final double temp;
  const WeatherDetailScreen({Key? key, required this.title, required this.temp})
      : super(key: key);

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var tt = Provider.of<WeatherDetailNotifier>(context);
    var temp = Provider.of<WeatherDetailNotifier>(context).getTemp();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Consumer<WeatherDetailNotifier>(
                builder: (context, WeatherDetailNotifier weatherDetail, _) {
              if (weatherDetail.loading) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ));
              } else if (weatherDetail.error) {
                return const Text(
                  "Something Wrong",
                  style: TextStyle(color: Colors.white),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              weatherDetail.weatherModel!.consolidatedWeather![0]
                                      .applicableDate ??
                                  "",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const Divider(),
                          const Text(
                            "Max Temp",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            weatherDetail
                                .weatherModel!.consolidatedWeather![0].maxTemp!
                                .toStringAsFixed(2),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Divider(),
                          const Text(
                            "Min Temp",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            weatherDetail
                                .weatherModel!.consolidatedWeather![0].minTemp!
                                .toStringAsFixed(2),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Divider(),
                          const Text(
                            "Current Temp",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            weatherDetail
                                .weatherModel!.consolidatedWeather![0].theTemp!
                                .toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          const Divider(),
                          CachedNetworkImage(
                            width: 70,
                            height: 85,
                            imageUrl: weatherDetail.getImgUrl(
                                "${weatherDetail.weatherModel!.consolidatedWeather![0].weatherStateAbbr}",
                                0),
                            placeholder: (_, __) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                ),
                              );
                            },
                            errorWidget: (_, __, ___) {
                              return const Center(
                                child: Icon(Icons.error),
                              );
                            },
                            fadeInDuration: const Duration(
                              seconds: 1,
                            ),
                            fadeInCurve: Curves.easeIn,
                          ),
                          const Divider(),
                          Text(
                            weatherDetail.weatherModel!.consolidatedWeather![0]
                                .weatherStateName!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E3311).withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          var apiDate = weatherDetail.weatherModel!
                              .consolidatedWeather![index + 1].applicableDate!;

                          return Column(
                            children: [
                              Container(
                                child: Text(
                                  convertDate(apiDate, index),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 170,
                                height: 250,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      weatherDetail
                                          .weatherModel!
                                          .consolidatedWeather![index + 1]
                                          .weatherStateName!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CachedNetworkImage(
                                      width: 80,
                                      height: 100,
                                      imageUrl: weatherDetail.getImgUrl(
                                          "${weatherDetail.weatherModel!.consolidatedWeather![index + 1].weatherStateAbbr}",
                                          index),
                                      placeholder: (_, __) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                      errorWidget: (_, __, ___) {
                                        return const Center(
                                          child: Icon(Icons.error),
                                        );
                                      },
                                      fadeInDuration: const Duration(
                                        seconds: 2,
                                      ),
                                      fadeInCurve: Curves.easeInOutQuad,
                                    ),
                                    Text(
                                      "${weatherDetail.weatherModel!.consolidatedWeather![index + 1].theTemp!.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0E3311).withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              );
            }),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: tt.weatherModel == null
                      ? [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 255, 255, 255),
                        ]
                      : tt.bgChangeColor(temp)),
            ),
          ),
        ));
  }

  String convertDate(String apiDate, int index) {
    var date = apiDate;
    // weatherDetail.weatherModel!.consolidatedWeather![index].applicableDate;
    var formatter = DateFormat('yyyy-MM-dd');
    var formatted = formatter.parse(date);
    var formatter2 = DateFormat('MEd');
    var result = formatter2.format(formatted);

    return result;
  }
}
