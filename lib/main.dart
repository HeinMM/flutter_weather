import 'package:flutter/material.dart';
import 'package:flutter_weather/view/change_notifier/search_city_notifier.dart';
import 'package:flutter_weather/view/change_notifier/weather_detail_notifier.dart';
import 'package:flutter_weather/view/screen/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CitySearchNotifier()),
        ChangeNotifierProvider(create: (_) => WeatherDetailNotifier())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme:
            const  AppBarTheme(color: Colors.indigo),
          primarySwatch: Colors.indigo,
          primaryColor: Colors.indigo,
        ),
        home:const SearchScreen(),
      ),
    );
  }
}
