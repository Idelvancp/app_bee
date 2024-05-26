enum State {
  belowNormal,
  aboveNormal,
  normal,
}

class PopulationData {
  final int id;
  final int numberBee;
  final double age;
  final State eggs;
  final State larvae;
  final State pupa;

  const PopulationData({
    required this.id,
    required this.numberBee,
    required this.age,
    required this.eggs,
    required this.larvae,
    required this.pupa,
  })
}
