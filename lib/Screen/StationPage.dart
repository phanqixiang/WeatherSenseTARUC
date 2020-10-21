import 'package:flutter/material.dart';
import 'package:weathersense_taruc_2020/constants.dart';
import 'package:weathersense_taruc_2020/Screen/SettingPage.dart';

class StationPage extends StatefulWidget {
  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Station',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Center(
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (context) => SettingPage(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
