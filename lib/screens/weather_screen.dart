import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../utils/appbar.dart';
import '../utils/custom_button.dart';
import '../utils/customcontainer.dart';
import 'dart:convert';
import '../constants/constants.dart' as k;

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Screen> {
  bool isloaded = false;
  num? temperature;
  num? pressure;
  num? humidity;
  num? cover;
  String cityname = '';

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(
          title: 'Weather Details',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Check City Weather',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    text: 'Hyderabad',
                    height: 40,
                    width: 120,
                    onPressed: () {
                      getCityWeather('Hyderabad');
                    },
                  ),
                  CustomButton(
                    text: 'Delhi',
                    height: 40,
                    width: 80,
                    onPressed: () {
                      getCityWeather('Delhi');
                    },
                  ),
                  CustomButton(
                    text: 'Bengaluru',
                    height: 40,
                    width: 120,
                    onPressed: () {
                      getCityWeather('Bengaluru');
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: isloaded,
                replacement: SizedBox(
                  height: MediaQuery.of(context).size.height * .6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: Colors.teal,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Loading.....',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.pin_drop,
                            size: 30,
                            color: Colors.red,
                          ),
                          Expanded(
                            child: Text(
                              cityname,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomCard(
                      text: 'Temperature: ${temperature?.toStringAsFixed(1)}ºC',
                      image: 'assets/images/thermometer.png',
                    ),
                    CustomCard(
                      text: 'Pressure: ${pressure?.toInt()} hPa',
                      image: 'assets/images/pressure.png',
                    ),
                    CustomCard(
                      text: 'Humidity: ${humidity?.toInt()} %',
                      image: 'assets/images/humidity.png',
                    ),
                    CustomCard(
                        text: 'Cloud cover: ${cover?.toInt()} %',
                        image: 'assets/images/cloud.png'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Allow location access to get your current location weather details'),
        ),
      );
      getCityWeather('');

      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Allow location access to get your current location weather details'),
          ),
        );
        getCityWeather('');

        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Allow location access to get your current location weather details'),
        ),
      );
      getCityWeather('');
      return;
    }

    var p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );
    if (p != null) {
      getCurrentCityWeather(p);
    } else {
      print('Data Unavailable');
    }
  }

  getCityWeather(String cityname) async {
    var client = http.Client();
    var decodedData;
    var uri = '${k.domain}q=$cityname&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = json.decode(data);
      updateUI(decodedData);
      setState(() {
        isloaded = true;
      });
    } else {
      decodedData = null;
      updateUI(decodedData);
      setState(() {
        isloaded = true;
      });

      print("Cannot fetch the city weather ${response.statusCode}");
    }
  }

  getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = json.decode(data);
      updateUI(decodedData);
      setState(() {
        isloaded = true;
      });
    } else {
      print(response.statusCode);
    }
  }

  updateUI(var decodedData) {
    setState(() {
      if (decodedData == null) {
        temperature = 0;
        pressure = 0;
        humidity = 0;
        cover = 0;
        cityname = "Not available";
      } else {
        temperature = decodedData['main']['temp'] - 273;
        pressure = decodedData['main']['pressure'];
        humidity = decodedData['main']['humidity'];
        cover = decodedData['clouds']['all'];
        cityname = decodedData['name'];
      }
    });
  }
}
