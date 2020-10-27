import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:weathersense_taruc_2020/main.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String asset = "assets/loading.flr";
    return SplashScreen.callback(
      name: asset,
      onSuccess: (_) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WeatherSenseApp()),
            (Route<dynamic> route) => false);
        /* context,
        */
      },
      onError: (e, s) {},
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.1,
      startAnimation: '0',
      endAnimation: '4',
      loopAnimation: 'start',
      backgroundColor: Colors.white,
      until: () => Future.delayed(Duration(milliseconds: 4)),
    );
  }
}
