import 'package:json_annotation/json_annotation.dart';

class DurationConverter implements JsonConverter<Duration, String> {
  const DurationConverter();

  @override
  Duration fromJson(String json) {
    final list = json.split(':');
    if (list.length != 2) return const Duration(minutes: 0);

    final minutes = int.tryParse(list[0]) ?? 0;
    final seconds = int.tryParse(list[1]) ?? 0;

    return Duration(minutes: minutes, seconds: seconds);
  }

  @override
  String toJson(Duration object) {
    final minutes = object.inMinutes;
    final seconds = (object.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

}