import 'package:flutter/material.dart';
import 'package:techsters_test/screens/weather_screen.dart';
import '../constants/constants.dart';
import '../utils/appbar.dart';
import '../utils/custom_button.dart';
import '../utils/gatepass.dart';
import '../utils/leave.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void showmodel() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .827,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 45,
                      child: TabBar(
                        labelColor: Colors.black,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                        indicatorColor: Colors.teal,
                        indicatorPadding:
                            const EdgeInsets.only(left: 20, right: 20),
                        indicatorWeight: 3,
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: 'Gate Pass',
                          ),
                          Tab(
                            text: 'Leave',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 480,
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          TabViewGatePass(),
                          TabViewLeave(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBar(
          title: 'Gatepass/Leave',
          onPressed: () {},
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Check weather details',
                    style: textStyle,
                  ),
                  CustomButton(
                    text: 'Go',
                    height: 35,
                    width: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Screen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Gatepass/Leave',
                    style: textStyle,
                  ),
                  CustomButton(
                    text: 'Get',
                    height: 50,
                    width: 60,
                    onPressed: () {
                      showmodel();
                    },
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
