class Collect {
  final int? id;
  final DateTime date;
  final double amountHoney;
  final double? amountPropolis;
  final double? amountWax;
  final double? amountRoyalJelly;
  final int apiaryId;
  final int hiveId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Collect(
      {this.id,
      required this.date,
      required this.amountHoney,
      this.amountPropolis,
      this.amountWax,
      this.amountRoyalJelly,
      required this.apiaryId,
      required this.hiveId,
      required this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'honey': amountHoney,
      'propolis': amountPropolis,
      'wax': amountWax,
      'royal_jelly': amountRoyalJelly,
      'apiary_id': apiaryId,
      'hive_id': hiveId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Converte um Map em um objeto Specie
  factory Collect.fromMap(Map<String, dynamic> map) {
    return Collect(
      id: map['id'],
      date: DateTime.parse(map['date']),
      amountHoney: map['honey'],
      amountPropolis: map['propolis'],
      amountWax: map['wax'],
      amountRoyalJelly: map['royal_jelly'],
      apiaryId: map['apiary_id'],
      hiveId: map['hive_id'],
      createdAt:
          DateTime.parse(map['created_at']), // Convertendo de string ISO 8601
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
