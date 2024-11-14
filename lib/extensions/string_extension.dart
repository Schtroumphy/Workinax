extension NullableStringExtension on String? {
  String get orNA => this ?? 'N/A';
}
