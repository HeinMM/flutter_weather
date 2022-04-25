import 'package:flutter/material.dart';
import 'package:flutter_weather/data/model/city_model.dart';
import 'package:flutter_weather/view/change_notifier/search_city_notifier.dart';
import 'package:flutter_weather/view/change_notifier/weather_detail_notifier.dart';
import 'package:flutter_weather/view/screen/weather_detail_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_searchController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please Enter City'),
                            ),
                          );
                        } else {
                          Provider.of<CitySearchNotifier>(context, listen: false)
                              .searchCity(city: _searchController.text);
                        }
                      },
                      icon: const Icon(Icons.search),
                    ),
                    hintText: 'Search City (Yangon)',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Consumer<CitySearchNotifier>(builder: (_, citySearchNotifier, ___) {
                  List<CityModel> cities = citySearchNotifier.cities;
                  if (citySearchNotifier.loading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(50.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (citySearchNotifier.error) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(50.0),
                        child: Text('Something wrong'),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Provider.of<WeatherDetailNotifier>(context,
                                      listen: false)
                                  .getWeatherInfo(cities[index].woeid.toString());

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                  
                                    
                                    return WeatherDetailScreen(
                                      title: cities[index].title ?? "",
                                      temp: 0.0,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(0.5),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(cities[index].title ?? ""),
                              ),
                            ),
                          );
                        }),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
