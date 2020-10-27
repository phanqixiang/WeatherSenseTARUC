import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weathersense_taruc_2020/Components/setting_button.dart';
import 'package:weathersense_taruc_2020/Model/MQTTWeather.dart';
import 'package:weathersense_taruc_2020/State/MQTTAppState.dart';
import 'package:weathersense_taruc_2020/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:weathersense_taruc_2020/Controller/mqtt_controller.dart';
import 'package:intl/intl.dart';
import 'package:connectivity/connectivity.dart';

class RealtimePage extends StatefulWidget {
  @override
  _RealtimePageState createState() => _RealtimePageState();
}

class _RealtimePageState extends State<RealtimePage> {
  MQTTManager manager;
  MQTTAppState appState;
  String _dateStr;
  String _timeStr;
  Timer _timer;
  @override
  void initState() {
    _dateStr = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _timeStr = DateFormat('hh:mm:ss').format(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());

    super.initState();
  }

  @override
  void dispose() {
    if (manager != null) manager.disconnect();
    _timer.cancel();
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate

    super.deactivate();
  }

  void getTime() {
    setState(() {
      final DateTime currentTime = DateTime.now();
      setState(() {
        _dateStr = DateFormat('dd/MM/yyyy').format(currentTime);
        _timeStr = DateFormat('hh:mm:ss').format(currentTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final MQTTAppState currentAppState =
        Provider.of<MQTTAppState>(context, listen: false);
    appState = currentAppState;
    return Scaffold(
      body: Column(
        children: [
          //Header
          RealtimeHeader(
            dateStr: _dateStr,
            timeStr: _timeStr,
          ),
          //Content
          RealtimeContent(),
          //Start/stop button
          buildRealtimeButton(
              connectionState: appState.getAppConnectionState,
              manager: manager),
        ],
      ),
      appBar: AppBar(
        actions: [
          SettingButton(),
        ],
        centerTitle: true,
        title: Text(
          'Realtime monitoring',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildRealtimeButton(
      {MQTTManager manager, MQTTAppConnectionState connectionState}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(bottom: 5),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: connectionState == MQTTAppConnectionState.connected
            ? buildStopButton(context, manager)
            : buildStartButton(context, manager),
      ),
    );
  }

  FlatButton buildStartButton(BuildContext context, MQTTManager manager) {
    Text startText =
        Text("Start", style: TextStyle(fontSize: 18, color: Colors.white));
    Widget buttonChild = startText;
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: mainColor,
      child: buttonChild,
      onPressed: () {
        setState(() {
          _connect(context);
        });
      },
    );
  }

  FlatButton buildStopButton(BuildContext context, MQTTManager manager) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.red,
      child: Text("Stop", style: TextStyle(fontSize: 18, color: Colors.white)),
      onPressed: () {
        manager.disconnect();
      },
    );
  }

  Future<bool> _connect(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      // I am connected to a mobile network.
      String osPrefix = 'Flutter_iOS';
      if (Platform.isAndroid) {
        osPrefix = 'Flutter_Android';
      }

      manager = MQTTManager(
          identifier: osPrefix,
          state: Provider.of<MQTTAppState>(context, listen: false));
      manager.initializeMQTTClient();
      manager.connect();

      return true;
    } else {
      // I am connected to a wifi network.
      print('No wifi');
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertDialog(
          elevation: 10,
          title: Text('No Internet connection'),
          content: Icon(
            Icons.close,
            color: Colors.red,
            size: 20,
          ),
          actions: [
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.pop(_);
              },
            )
          ],
        ),
      );
      return false;
    }
  }
}

class RealtimeContent extends StatelessWidget {
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<MQTTAppState>(
        builder: (context, appState, child) {
          MQTTWeather weather = appState.weatherData;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: backColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      SingleDataBox(
                        dataIconUrl: "assets/Temperature.svg",
                        dataUnit: "Temp (°C)",
                        dataValue: weather.temp,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SingleDataBox(
                        dataIconUrl: "assets/Humidity.svg",
                        dataUnit: "Humidity (%)",
                        dataValue: weather.humidity,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      SingleDataBox(
                        dataIconUrl: "assets/Pressure.svg",
                        dataUnit: "Pressure (Pa)",
                        dataValue: weather.pressure,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SingleDataBox(
                        dataIconUrl: "assets/Hail.svg",
                        dataUnit: "Hail (s)",
                        dataValue: weather.hailDuration.toDouble(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      MultiDataBox(
                        dataUnit: "Wind Direction (°)",
                        avgValue: weather.avgWindDirection,
                        maxValue: weather.maxWindDirection,
                        minValue: weather.minWindDirection,
                        dataIconUrl: "assets/direction.svg",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MultiDataBox(
                        dataUnit: "Wind Speed (m/s)",
                        avgValue: weather.avgWindSpeed,
                        maxValue: weather.maxWindSpeed,
                        minValue: weather.minWindSpeed,
                        dataIconUrl: "assets/wind.svg",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: buildRainDataBox(
                    accumulation: weather.rainAccumulation,
                    duration: weather.rainDuration,
                    intensity: weather.rainIntensity,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildRainDataBox(
          {double intensity, int duration, double accumulation}) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: SvgPicture.asset(
                    "assets/rain.svg",
                  )),
                  SizedBox(height: 12),
                  Text('Rain', style: TextStyle(fontSize: 15))
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Intensity (mm/h)'),
                            SizedBox(height: 3),
                            Text(intensity.toString(), style: boldFontStyle),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Duration (s)',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 3),
                            Text(duration.toString(), style: boldFontStyle),
                          ],
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text('Accumulation (mm)'),
                        SizedBox(height: 3),
                        Text(
                          accumulation.toString(),
                          style: boldFontStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class MultiDataBox extends StatelessWidget {
  final String dataIconUrl;
  final double minValue;
  final double maxValue;
  final double avgValue;
  final String dataUnit;

  MultiDataBox(
      {this.dataIconUrl,
      this.dataUnit,
      this.avgValue,
      this.maxValue,
      this.minValue});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(dataIconUrl),
            ),
            SizedBox(height: 10),
            Text(dataUnit),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Min',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text(minValue.toString(), style: boldFontStyle),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Avg',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text(avgValue.toString(), style: boldFontStyle),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Max',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text(maxValue.toString(), style: boldFontStyle),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SingleDataBox extends StatelessWidget {
  final String dataIconUrl;
  final double dataValue;
  final String dataUnit;

  SingleDataBox({this.dataIconUrl, this.dataUnit, this.dataValue});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: SvgPicture.asset(
                dataIconUrl,
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(dataUnit, overflow: TextOverflow.ellipsis),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    dataValue.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RealtimeButton extends StatelessWidget {
  MQTTManager manager;
  MQTTAppConnectionState connectionState;
  RealtimeButton({this.manager, this.connectionState});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: connectionState == MQTTAppConnectionState.connected
            ? buildStopButton(context, manager)
            : buildStartButton(context, manager),
      ),
    );
  }

  FlatButton buildStartButton(BuildContext context, MQTTManager manager) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: mainColor,
      child: Text("Start", style: TextStyle(fontSize: 18, color: Colors.white)),
      onPressed: () {
        _connect(context);
      },
    );
  }

  FlatButton buildStopButton(BuildContext context, MQTTManager manager) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.red,
      child: Text("Stop", style: TextStyle(fontSize: 18, color: Colors.white)),
      onPressed: () {
        manager.disconnect();
      },
    );
  }

  void _connect(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      // I am connected to a mobile network.
      String osPrefix = 'Flutter_iOS';
      if (Platform.isAndroid) {
        osPrefix = 'Flutter_Android';
      }

      manager = MQTTManager(
          identifier: osPrefix,
          state: Provider.of<MQTTAppState>(context, listen: false));
      manager.initializeMQTTClient();
      manager.connect();
    } else {
      // I am connected to a wifi network.
      print('No wifi');
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertDialog(
          elevation: 10,
          title: Text('No Internet connection'),
          content: Icon(
            Icons.close,
            color: Colors.red,
            size: 20,
          ),
          actions: [
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.pop(_);
              },
            )
          ],
        ),
      );
    }
  }
}

class RealtimeHeader extends StatelessWidget {
  final String timeStr;
  final String dateStr;

  RealtimeHeader({this.dateStr = "", this.timeStr = ""});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Station label
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 1, color: Color(0xff707070).withOpacity(0.2)),
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff07096A),
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(text: 'Station ID: '),
                          TextSpan(
                            text: 'TARUC_GF',
                            style: TextStyle(
                              color: Color(0xff6B6EF5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //Time
                Text(
                  timeStr,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color(0xff707070).withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    dateStr,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                // SvgPicture.asset('assets/triangle.svg', fit: BoxFit.fitWidth),

                Image.asset("assets/triangle.png"),
                SvgPicture.asset(
                  'assets/clock.svg',
                  width: 120,
                ),

                //Image.asset("assets/clock.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
