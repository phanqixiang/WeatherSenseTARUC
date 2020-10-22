import 'package:flutter/material.dart';
import 'package:weathersense_taruc_2020/constants.dart';
import 'package:weathersense_taruc_2020/main.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      padding: EdgeInsets.only(top: 30, bottom: 30),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      child: Column(
        children: [
          AppBar(
            centerTitle: true,
            elevation: 0,
            leading: IconButton(icon: Icon(Icons.close, color: Colors.white)),
            title: Text(
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: SvgPicture.asset(
              'assets/settings.svg',
              width: headerIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
