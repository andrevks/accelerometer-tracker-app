import 'dart:convert';

AccelerometerModel accelerometerModelFromJson(String str) =>
    AccelerometerModel.fromJson(json.decode(str));
String accelerometerModelToJson(AccelerometerModel data) =>
    json.encode(data.toJson());

class AccelerometerModel {
  AccelerometerModel({
    required this.title,
    required this.x,
    required this.y,
    required this.z,
  });
  String title;
  String x;
  String y;
  String z;
  factory AccelerometerModel.fromJson(Map<String, dynamic> json) =>
      AccelerometerModel(
        title: json["title"],
        x: json["x"],
        y: json["y"],
        z: json["z"],
      );
  Map<String, dynamic> toJson() => {
        "title": title,
        "x": x,
        "y": y,
        "z": z,
      };
}
