import 'package:flutter/material.dart';
import 'package:weathersense_taruc_2020/Screen/SettingPage.dart';

class SettingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
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
    );
  }
}
