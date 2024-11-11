extension DurationExtension on Duration? {
  String get formatDuration {
    final duration = this;
    if (duration == null) return '';

    final buffer = StringBuffer();

    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) buffer.write('${hours}h ');

    if (minutes > 0) buffer.write('${minutes}m ');

    if (seconds > 0) buffer.write('${seconds}s');

    return buffer.isEmpty ? 'Ø' : buffer.toString().trim();
  }

  String get formatClockDuration {
    final duration = this;
    if (duration == null) return '00:00:00';

    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  Duration get orZero => this ?? Duration.zero;
}
