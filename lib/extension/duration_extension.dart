extension DurationExtension on Duration? {

  String get formatDuration {
    final duration = this;
    if(duration == null) return '00:00';
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  String get formatShortDuration {
    final duration = this;
    if(duration == null) return '00:00';

    final hours = (duration.inHours % 60).toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  Duration get orZero => this ?? Duration.zero;

}