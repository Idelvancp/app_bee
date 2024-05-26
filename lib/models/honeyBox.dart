enum State { goodCondition, poorCondition }

class HoneyBox {
  final int id;
  final int hiveID;
  final int numberFrames;
  final int busyFrames;
  final State state;

  const HoneyBox({
    required this.id,
    required this.hiveID,
    required this.numberFrames,
    required this.busyFrames,
    required this.state,
  });
}
