// To parse this JSON data, do
//
//     final statusModel = statusModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class StatusModel {
  StatusModel({
    @required this.temperature,
    @required this.humidity,
    @required this.soil,
    @required this.ph,
  });

  int temperature;
  int humidity;
  int soil;
  double ph;

  factory StatusModel.fromJson(String str) =>
      StatusModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusModel.fromMap(Map<dynamic, dynamic> json) => StatusModel(
        temperature: json["temperature"],
        humidity: json["humidity"],
        soil: json["soil"],
        ph: json["ph"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "temperature": temperature,
        "humidity": humidity,
        "soil": soil,
        "ph": ph,
      };
}
