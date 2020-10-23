// Convert MQTT message into readable weather data
String convert(String mqttMsg, String dataUnit) {
  int startIndex = mqttMsg.indexOf(dataUnit) + 3;
  int endIndex =
      mqttMsg.substring(startIndex, mqttMsg.length - 1).indexOf(',') -
          1 +
          startIndex;
  return mqttMsg.substring(startIndex, endIndex);
}
