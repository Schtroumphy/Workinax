import 'package:json_annotation/json_annotation.dart';
import 'package:workinax/core/constants/app_date_format.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}

class SimpleDateTimeConverter implements JsonConverter<DateTime, String> {
  const SimpleDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) =>
      AppDateFormat.dbShortDateFormat.format(object);
}
