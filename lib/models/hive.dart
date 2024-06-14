import 'package:flutter/material.dart';

class Hive with ChangeNotifier {
  final int id;
  final int apiaryId;
  final int specieId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Hive(
      {required this.id,
      required this.apiaryId,
      required this.specieId,
      required this.createdAt,
      this.updatedAt});
  // Converte um Specie em um Map para salvar no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'apiayId': apiaryId,
      'specieId': specieId,
      'created_at':
          createdAt.toIso8601String(), // Convertendo para string ISO 8601
      'updated_at':
          updatedAt?.toIso8601String(), // Convertendo para string ISO 8601
    };
  }

  // Converte um Map em um objeto Hive
  factory Hive.fromMap(Map<String, dynamic> map) {
    return Hive(
      id: map['id'],
      apiaryId: map['apiaryId'],
      specieId: map['specieId'],
      createdAt:
          DateTime.parse(map['created_at']), // Convertendo de string ISO 8601
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
