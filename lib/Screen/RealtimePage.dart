import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weathersense_taruc_2020/Components/setting_button.dart';
import 'package:weathersense_taruc_2020/constants.dart';

class RealtimePage extends StatefulWidget {
  @override
  _RealtimePageState createState() => _RealtimePageState();
}

class _RealtimePageState extends State<RealtimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Header
          RealtimeHeader(),
          //Content
          RealtimeContent(),
          //Start/stop button

          RealtimeButton()
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
}

class RealtimeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        color: Colors.blueAccent,
        child: Column(
          children: [],
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
        height: 50,
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
                SvgPicture.asset('assets/clock.svg'),

                //Image.asset("assets/clock.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
