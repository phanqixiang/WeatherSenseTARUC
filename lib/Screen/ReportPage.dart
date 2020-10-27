import 'package:flutter/material.dart';
import 'package:weathersense_taruc_2020/Components/setting_button.dart';
import 'package:weathersense_taruc_2020/constants.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title:
              Text('Weather Reporting', style: TextStyle(color: Colors.white)),
          actions: [SettingButton()],
          bottom: PreferredSize(
            preferredSize: Size(200, 60),
            child: Container(
              padding: EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
              child: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                indicatorColor: Colors.black,
                indicatorWeight: 6,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    child: Container(
                      child: Text(
                        'History',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('History'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
