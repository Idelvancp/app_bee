class Inspection {
  final int id;
  final DateTime date;
  final int hiveId;
  final int typeInspectionId;
  final int? populationDataId;
  final int? productId;
  final int envionrimentDataId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Inspection({
    required this.id,
    required this.date,
    required this.hiveId,
    required this.typeInspectionId,
    this.populationDataId,
    this.productId,
    required this.envionrimentDataId,
    required this.createdAt,
    this.updatedAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'hive_id': hiveId,
      'type_inspection_id': typeInspectionId,
      'population_data_id': populationDataId,
      'product_id': productId,
      'environment_data_id': envionrimentDataId,
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
      date: map['date'],
      hiveId: map['hive_id'],
      typeInspectionId: map['type_inspection_id'],
      populationDataId: map['population_data_id'],
      productId: map['product_id'],
      envionrimentDataId: map['environment_data_id'],
      createdAt:
          DateTime.parse(map['created_at']), // Convertendo de string ISO 8601
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
