import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weathersense_taruc_2020/Components/setting_button.dart';
import 'package:weathersense_taruc_2020/State/MQTTAppState.dart';
import 'package:weathersense_taruc_2020/constants.dart';
import 'package:flutter/cupertino.dart';

class RealtimePage extends StatefulWidget {
  @override
  _RealtimePageState createState() => _RealtimePageState();
}

class _RealtimePageState extends State<RealtimePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MQTTAppState>(
      create: (context) => MQTTAppState(),
      child: Scaffold(
        body: Column(
          children: [
            //Header
            RealtimeHeader(),
            //Content
            RealtimeContent(),
            //Start/stop button
            RealtimeButton(),
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
      ),
    );
  }
}

class RealtimeContent extends StatefulWidget {
  @override
  _RealtimeContentState createState() => _RealtimeContentState();
}

class _RealtimeContentState extends State<RealtimeContent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                    dataValue: 42.4,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SingleDataBox(
                    dataIconUrl: "assets/Humidity.svg",
                    dataUnit: "Humidity (%)",
                    dataValue: 42.4,
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
                    dataValue: 42.4,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SingleDataBox(
                    dataIconUrl: "assets/Hail.svg",
                    dataUnit: "Hail (s)",
                    dataValue: 42.4,
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
                  MultiDataBox(),
                  SizedBox(
                    width: 10,
                  ),
                  MultiDataBox()
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: buildRainDataBox(),
            ),
          ],
        ),
      ),
    );
  }

  Container buildRainDataBox() => Container(
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
      );
}

class MultiDataBox extends StatelessWidget {
  final Icon dataIcon;
  final double minValue;
  final double maxValue;
  final double avgValue;
  final String dataUnit;

  MultiDataBox(
      {this.dataIcon,
      this.dataUnit,
      this.avgValue,
      this.maxValue,
      this.minValue});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                    height: 5,
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: mainColor,
          child: Text('Start',
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onPressed: () {},
        ),
      ),
    );
  }
}

class RealtimeHeader extends StatelessWidget {
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
                  '14:24:43',
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
                    '22/10/2020',
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
