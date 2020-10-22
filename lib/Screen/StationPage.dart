import 'package:flutter/material.dart';
import 'package:weathersense_taruc_2020/Components/setting_button.dart';

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
        centerTitle: true,
        title: Text(
          'Station Management',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Center(
            child: SettingButton(),
          ),
        ],
      ),
    );
  }
}
