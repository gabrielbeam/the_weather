import 'package:json_annotation/json_annotation.dart';

part 'precipitation_response.g.dart';

@JsonSerializable()
class PrecipitationResponse {
  String status;
  List<Data> data;

  PrecipitationResponse({
    required this.status,
    required this.data,
  });

  factory PrecipitationResponse.fromJson(Map<String, dynamic> json) =>
      _$PrecipitationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrecipitationResponseToJson(this);
}

@JsonSerializable()
class Data {
  String parameter;
  List<Coordinates> coordinates;

  Data({
    required this.parameter,
    required this.coordinates,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Coordinates {
  double lat;
  double lon;
  List<Dates> dates;

  Coordinates({
    required this.lat,
    required this.lon,
    required this.dates,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}

@JsonSerializable()
class Dates {
  String date;
  double value;

  Dates({
    required this.date,
    required this.value,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}
