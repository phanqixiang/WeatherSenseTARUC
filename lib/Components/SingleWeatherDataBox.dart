import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weathersense_taruc_2020/State/RealtimeState.dart';
import 'package:weathersense_taruc_2020/Components/RealtimeManager.dart';

class SingleWeatherDataBox extends StatelessWidget {
  String parameter = "";
  String value = "";
  @override
  SingleWeatherDataBox({this.parameter, this.value});
  Widget build(BuildContext context) {
    final TextEditingController _hostTextController = TextEditingController();
    final TextEditingController _messageTextController =
        TextEditingController();
    final TextEditingController _topicTextController = TextEditingController();
    RealtimeState currentAppState;

    MQTTManager manager;
    return Expanded(
      child: Container(
        child: Center(
          child: ListTile(
            leading: SvgPicture.asset(
              'assets/${parameter}.svg',
              height: 40,
              width: 40,
            ),
            title: Center(child: Text(parameter)),
            subtitle: Center(
              child: Text(
                value.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white10,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
