import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:weathersense_taruc_2020/Model/MQTTWeather.dart';

enum MQTTAppConnectionState {
  connected,
  disconnected,
  connecting,
}

class MQTTAppState with ChangeNotifier {
  MQTTAppConnectionState _appConnectionState =
      MQTTAppConnectionState.disconnected;
  String _receivedText = '';
  String _historyText = '';
  MQTTWeather weatherData;

  void setReceivedText(String text) {
    weatherData = MQTTWeather(text);
    notifyListeners();
  }

  void setAppConnectionState(MQTTAppConnectionState state) {
    _appConnectionState = state;
    notifyListeners();
  }

  String get getReceivedText => _receivedText;
  String get getHistoryText => _historyText;
  MQTTAppConnectionState get getAppConnectionState => _appConnectionState;
}
