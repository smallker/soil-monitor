// To parse this JSON data, do
//
//     final historyModel = historyModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class HistoryModel {
  HistoryModel({
    @required this.temperature,
    @required this.humidity,
    @required this.soil,
    @required this.ph,
    @required this.timestamp,
  });

  int temperature;
  int humidity;
  int soil;
  double ph;
  int timestamp;

  factory HistoryModel.fromJson(String str) =>
      HistoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromMap(Map<dynamic, dynamic> json) => HistoryModel(
        temperature: json["temperature"],
        humidity: json["humidity"],
        soil: json["soil"],
        ph: json["ph"].toDouble(),
        timestamp: int.parse(json["timestamp"]) * 1000,
      );

  Map<String, dynamic> toMap() => {
        "temperature": temperature,
        "humidity": humidity,
        "soil": soil,
        "ph": ph,
        "timestamp": timestamp,
      };
}
