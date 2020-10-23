import 'package:weathersense_taruc_2020/service.dart';

class MQTTWeather {
  double _temp = 0;
  double _humidity = 0;
  double _pressure = 0;
  int _hailDuration = 0;
  int _rainDuration = 0;
  double _rainIntensity = 0;
  double _rainAccumulation = 0;

  double _minWindDirection = 0;
  double _avgWindDirection = 0;
  double _maxWindDirection = 0;

  double _minWindSpeed = 0;
  double _maxWindSpeed = 0;
  double _avgWindSpeed = 0;

  MQTTWeather(String weatherData) {
    _temp = double.parse(convert(weatherData, 'Ta'));
    _humidity = double.parse(convert(weatherData, 'Ua'));
    _pressure = double.parse(convert(weatherData, 'Pa'));
    _hailDuration = int.parse(convert(weatherData, 'Hd'));
    _rainDuration = int.parse(convert(weatherData, 'Rd'));
    _rainIntensity = double.parse(convert(weatherData, 'Ri'));
    _rainAccumulation = double.parse(convert(weatherData, 'Rc'));

    _minWindDirection = double.parse(convert(weatherData, 'Sn'));
    _avgWindDirection = double.parse(convert(weatherData, 'Sm'));
    _maxWindDirection = double.parse(convert(weatherData, 'Sx'));

    _minWindSpeed = double.parse(convert(weatherData, 'Dn'));
    _maxWindSpeed = double.parse(convert(weatherData, 'Dm'));
    _avgWindSpeed = double.parse(convert(weatherData, 'Dx'));
  }
  double get temp => _temp;
  double get humidity => _humidity;
  double get pressure => _pressure;
  int get hailDuration => _hailDuration;
  int get rainDuration => _rainDuration;
  double get rainIntensity => _rainIntensity;
  double get rainAccumulation => _rainAccumulation;

  double get minWindDirection => _minWindDirection;
  double get avgWindDirection => _avgWindDirection;
  double get maxWindDirection => _maxWindDirection;

  double get minWindSpeed => _minWindSpeed;
  double get maxWindSpeed => _maxWindSpeed;
  double get avgWindSpeed => _avgWindSpeed;
}

/*
temp = float(decode_data(weather_data, 'Ta'))
pressure = float(decode_data(weather_data, 'Pa'))
wind_speed = float(decode_data(weather_data, 'Sm'))
humidity = float(decode_data(weather_data, 'Ua'))
rain_intensity = float(decode_data(weather_data, 'Ri'))
rain_accumulation = float(decode_data(weather_data, 'Rc'))
rain_duration = float(decode_data(weather_data, 'Rd'))
hail_duration = float(decode_data(weather_data, 'Hd'))
supply_voltage = float(decode_data(weather_data, 'Vs'))
ref_voltage = float(decode_data(weather_data, 'Vr'))
internal_temp = float(decode_data(weather_data, 'Tp'))


*/
