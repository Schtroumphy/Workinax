enum ModeType {
  notStarted,
  workInProgress,
  breakInProgress,
  workEnd;

  static List<ModeType> get working => [
    workInProgress,
    breakInProgress,
  ];

  bool get isNotWorking => !working.contains(this);
  bool get isWorking => working.contains(this);
}