import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:workinax/extension/string_extension.dart';
import 'package:workinax/extension/time_of_day_extension.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  static final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  DateTime fromJson(String json) => dateFormat.parse(json);

  @override
  String toJson(DateTime object) => dateFormat.format(object);
}

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) => json.toTimeOfDay;

  @override
  String toJson(TimeOfDay object) => object.formatTimeOfDay;
}
