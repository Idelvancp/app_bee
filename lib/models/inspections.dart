enum TypeInstpection {
  routine,
  honeyColletion,
  queenReplacement,
  sanitaryControl,
}

class Inspections {
  final int id;
  final DateTime date;
  final int hiveId;
  final TypeInstpection typeInspection;
  final int populationDataId;
  final int envionrimentDataId;

  const Inspections({
    required this.id,
    required this.date,
    required this.hiveId,
    required this.typeInspection,
    required this.populationDataId,
    required this.envionrimentDataId,
  })
}
