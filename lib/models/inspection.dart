class Inspection {
  final int? id;
  final DateTime date;
  final int hiveId;
  final int apiaryId;
  final String typeInspectionId;
  int? populationDataId;
  int? environmentDataId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Inspection({
    this.id,
    required this.date,
    required this.hiveId,
    required this.apiaryId,
    required this.typeInspectionId,
    this.populationDataId,
    this.environmentDataId,
    required this.createdAt,
    this.updatedAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'hive_id': hiveId,
      'apiary_id': apiaryId,
      'type_inspection_id': typeInspectionId,
      'population_data_id': populationDataId,
      'environment_data_id': environmentDataId,
      'created_at':
          createdAt.toIso8601String(), // Convertendo para string ISO 8601
      'updated_at':
          updatedAt?.toIso8601String(), // Convertendo para string ISO 8601
    };
  }

  // Converte um Map em um objeto Specie
  factory Inspection.fromMap(Map<String, dynamic> map) {
    return Inspection(
      id: map['id'],
      date: DateTime.parse(map['date']),
      hiveId: map['hive_id'],
      apiaryId: map['apiary_id'],
      typeInspectionId: map['type_inspection_id'],
      populationDataId: map['population_data_id'],
      environmentDataId: map['environment_data_id'],
      createdAt:
          DateTime.parse(map['created_at']), // Convertendo de string ISO 8601
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
