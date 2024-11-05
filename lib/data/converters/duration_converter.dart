import 'package:json_annotation/json_annotation.dart';

class DurationConverter implements JsonConverter<Duration, String> {
  const DurationConverter();

  @override
  Duration fromJson(String json) {
    final list = json.split(':');
    if(list.length != 2) return const Duration(minutes: 0);

    return Duration(hours: int.tryParse(list[0]) ?? 0, minutes: int.tryParse(list[1]) ?? 0);
  }

  @override
  String toJson(Duration object) {
    return '${object.inHours}:${object.inMinutes}';
  }

}