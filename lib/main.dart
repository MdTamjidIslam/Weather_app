import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/settings_page.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/providers/weather_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_)=>WeatherProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'MerriweatherSans',

        primarySwatch: Colors.blue,
      ),
      initialRoute:WeatherPage.routeName,
      routes: {
        WeatherPage.routeName:(_)=> WeatherPage(),
        SettingsPage.routeName:(_)=> SettingsPage(),
      },
    );
  }
}


