import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screen/ForecastPage.dart';
import 'Screen/RealtimePage.dart';
import 'Screen/ReportPage.dart';
import 'Screen/SettingPage.dart';
import 'Screen/NotificationPage.dart';
import 'Screen/StationPage.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/clock.svg'), null);
  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/triangle.svg'),
      null);
  runApp(WeatherSenseApp());
}

class WeatherSenseApp extends StatefulWidget {
  @override
  _WeatherSenseAppState createState() => _WeatherSenseAppState();
}

class _WeatherSenseAppState extends State<WeatherSenseApp> {
  int _currentIndex = 0;
  final tabs = [
    StationPage(),
    ForecastPage(),
    RealtimePage(),
    ReportPage(),
    NotificationPage(),
  ];

  @override
  void initState() {
    precacheImage(AssetImage('assets/triangle.png'), context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: mainColor,
        accentColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              title: Text('Station'),
              icon: Icon(Icons.router),
            ),
            BottomNavigationBarItem(
              title: Text('Forecast'),
              icon: Icon(Icons.timeline),
            ),
            BottomNavigationBarItem(
              title: Text('Realtime'),
              icon: Icon(Icons.access_time),
            ),
            BottomNavigationBarItem(
              title: Text('Report'),
              icon: Icon(Icons.assessment),
            ),
            BottomNavigationBarItem(
              title: Text('Alert'),
              icon: Icon(Icons.notifications),
            ),
          ],
          onTap: (pressedIndex) {
            setState(() {
              _currentIndex = pressedIndex;
            });
          },
        ),
      ),
    );
  }
}

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  final FirebaseFirestore fireDb = FirebaseFirestore.instance;
  final int _count = 0;
  void test() {
    dbRef.child('testing').once().then((DataSnapshot snapshot) {
      print("Realtime value: ${snapshot.value}");
    });

    CollectionReference collectionReference = fireDb.collection('weather');

    collectionReference.snapshots().listen((snapshot) {
      int age = snapshot.docs[0].data()['age'];
      print('Age ${age}');
    });
    print('Test');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Realtime monitoring')),
        ),
        body: RealtimeView(),
      ),
    );
  }
}




 */
