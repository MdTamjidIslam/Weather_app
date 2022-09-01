import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/helper_functions.dart';

import '../providers/weather_provider.dart';
import '../utils/text_styles.dart';
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
        child:provider.hasDataLoaded ? ListView(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
          children: [
            _currentWeatherSection(),
            _forecastWeatherSection(),
          ],
        ):

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

 Widget _currentWeatherSection() {
    final current= provider.currentResponseModel;
    return Column(
      children: [
        Text(getFormattedDateTime(current!.dt!,'MMM dd,yyyy',),style: txtDateBig18,),
        Text('${current.name},${current.sys!.country}',style: txtAddress25 ,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('$iconPrefix${current.weather![0].icon}$iconSuffix',fit: BoxFit.cover,),
              Text('${current.main!.temp!.round()}$degree${provider.unitSymbol}',style: txtTempBig80,),
            ],
          ),
        ),
        Text('feels like ${current.main!.feelsLike}$degree${provider.unitSymbol}', style: txtNormal16White54,),
        Text('${current.weather![0].main} ${current.weather![0].description}', style: txtNormal16White54,),
        SizedBox(height: 15,),
        Wrap(
          children: [
            Text('Humidity ${current.main!.humidity}%',style: txtNormal16,),
            Text('Pressure ${current.main!.pressure} hpa ',style: txtNormal16,),
            Text('Visibility ${current.visibility} meter ',style: txtNormal16,),
            Text('Wind Speed ${current.wind!.speed} meter/sec ',style: txtNormal16,),
            Text('Degree ${current.wind!.deg} $degree ',style: txtNormal16,),
          ],
        ),
        SizedBox(height: 15,),
        Wrap(
          children: [
            Text('Sunrise: ${getFormattedDateTime(current.sys!.sunrise!, 'hh:mm a')}', style: txtNormal16White54,),
            const SizedBox(width: 10,),
            Text('Sunset: ${getFormattedDateTime(current.sys!.sunset!, 'hh:mm a')}', style: txtNormal16White54,),
          ],
        )
      ],
    );
 }

 Widget _forecastWeatherSection() {
    return Column();
 }
}
