import 'package:flutter/material.dart';
import 'package:techsters_test/utils/custom_button.dart';
import '../constants/constants.dart';
import '../utils/appbar.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
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
                style: textStyle,
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
                    onPressed: () {},
                  ),
                  CustomButton(
                    text: 'Delhi',
                    height: 40,
                    width: 80,
                    onPressed: () {},
                  ),
                  CustomButton(
                    text: 'Bangalore',
                    height: 40,
                    width: 120,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
