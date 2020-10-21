import 'package:flutter/material.dart';

class ForecastPage extends StatefulWidget {
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff28BC85),
        child: Center(
          child: Text(
            'Forecast',
          ),
        ),
      ),
    );
  }
}
