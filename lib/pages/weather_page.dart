import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../utils/location_service.dart';

class WeatherPage extends StatefulWidget {
  static const String routeName = '/';

  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherProvider provider;
  bool isFirst = true;
  @override
  void didChangeDependencies() {
    if(isFirst) {
      provider = Provider.of<WeatherProvider>(context);
      _detectLocation();
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Weather'),
        actions: [
          IconButton(onPressed: () {},
            icon: Icon(Icons.my_location)
          ),

          IconButton(onPressed: () {},
              icon: Icon(Icons.search)
          ),

          IconButton(onPressed: () {},
              icon: Icon(Icons.settings)
          ),

        ],
      ),
      body: Center(
        child:provider.hasDataLoaded ? ListView():
            Text('Please Loading'),
      ),
    );
  }

  void _detectLocation() {
    determinePosition().then((position) {
      provider.setNewLocation(position.latitude, position.longitude);
      provider.getWeatherData();
    });
  }
}
