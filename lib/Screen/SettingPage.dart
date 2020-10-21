import 'package:flutter/material.dart';
import 'package:weathersense_taruc_2020/constants.dart';
import 'package:weathersense_taruc_2020/main.dart';

class SettingPage extends StatelessWidget {
  AppBar appBar = AppBar(
    title: Text('Get Appbar Height'),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      color: mainColor,
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(icon: Icon(Icons.close, color: Colors.white)),
          ),
          Center(
            child: Icon(Icons.timeline, color: Colors.white, size: 50),
          ),
        ],
      ),
    );
  }
}
