import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/extension/string_extension.dart';
import 'package:workinax/widgets/edit_time_dialog.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => DateFormat('dd/MM/yyyy').format(object);
}

class DateTimeToTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeToTimeConverter();

  @override
  DateTime fromJson(String json) => json.toTimeOfDay.toDateTime();

  @override
  String toJson(DateTime object) =>
      TimeOfDay.fromDateTime(object).formatTimeOfDay;
}
