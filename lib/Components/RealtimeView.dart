import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:weathersense_taruc_2020/Components/SingleWeatherDataBox.dart';
import 'package:weathersense_taruc_2020/State/RealtimeState.dart';
import 'package:weathersense_taruc_2020/Components/RealtimeManager.dart';

class RealtimeView extends StatefulWidget {
  @override
  _RealtimeViewState createState() => _RealtimeViewState();
}

class _RealtimeViewState extends State<RealtimeView> {
  final TextEditingController _hostTextController = TextEditingController();
  final TextEditingController _messageTextController = TextEditingController();
  final TextEditingController _topicTextController = TextEditingController();
  RealtimeState currentAppState;
  MQTTManager manager;

  @override
  void initState() {
    _configureAndConnect();
    super.initState();
  }

  @override
  void dispose() {
    _hostTextController.dispose();
    _messageTextController.dispose();
    _topicTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RealtimeState appState = Provider.of<RealtimeState>(context);
    currentAppState = appState;
    return Container(
      color: Colors.white54,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SingleWeatherDataBox(
                parameter: "Temperature",
                value: "",
              ),
              SizedBox(
                width: 15,
              ),
              SingleWeatherDataBox(
                  parameter: "Humidity",
                  value:
                      currentAppState.getReceivedText == null ? 'nul' : '43'),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SingleWeatherDataBox(
                parameter: "Pressure",
                value: "",
              ),
              SizedBox(
                width: 15,
              ),
              SingleWeatherDataBox(
                parameter: "Hail",
                value: "",
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _configureAndConnect() {
    // TODO: Use UUID
    String osPrefix = 'Flutter_iOS';
    if (Platform.isAndroid) {
      osPrefix = 'Flutter_Android';
    }
    manager = MQTTManager(
        host: "test.mosquitto.org",
        topic: "weather990917145603/",
        identifier: osPrefix,
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect() {
    manager.disconnect();
  }
}
