enum ModeType {
  notStarted,
  workInProgress,
  breakInProgress,
  workEnd;

  static List<ModeType> get working => [
    workInProgress,
    breakInProgress,
  ];
}