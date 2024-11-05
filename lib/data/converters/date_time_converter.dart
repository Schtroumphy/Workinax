import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/extension/string_extension.dart';
import 'package:workinax/extension/time_of_day_extension.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => dbDateFormat.parse(json);

  @override
  String toJson(DateTime object) => dbDateFormat.format(object);
}

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) => json.toTimeOfDay;

  @override
  String toJson(TimeOfDay object) => object.formatTimeOfDay;
}
