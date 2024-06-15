import 'package:flutter/material.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/models/specie.dart';

class Hive with ChangeNotifier {
  final int id;
  final int honeyBoxId;
  final int specieId;
  final int apiaryId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Hive(
      {required this.id,
      required this.honeyBoxId,
      required this.specieId,
      required this.apiaryId,
      required this.createdAt,
      this.updatedAt});
  // Converte um Specie em um Map para salvar no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'honey_box_id': honeyBoxId,
      'specie_id': specieId,
      'apiary_id': apiaryId,
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
      honeyBoxId: map['honey_box_id'],
      specieId: map['specie_id'],
      apiaryId: map['apiary_id'],
      createdAt:
          DateTime.parse(map['created_at']), // Convertendo de string ISO 8601
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}

class HiveDetail {
  final Hive hive;
  final Specie specie;
  final Apiary apiary;

  HiveDetail({
    required this.hive,
    required this.specie,
    required this.apiary,
  });
}
