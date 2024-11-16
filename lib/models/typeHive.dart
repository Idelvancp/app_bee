import 'package:flutter/material.dart';

class TypeHive with ChangeNotifier {
  final int? id;
  final String name;
  final createdAt;
  final updatedAt;

  TypeHive({
    this.id,
    required this.name,
    required this.createdAt,
    this.updatedAt,
  });

  // Converte um Todo em um Map para salvar no banco de dados
  // Converte um TypeHive em um Map para salvar no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at':
          createdAt.toIso8601String(), // Convertendo para string ISO 8601
      'updated_at':
          updatedAt?.toIso8601String(), // Convertendo para string ISO 8601
    };
  }

  // Converte um Map em um objeto TypeHive
  factory TypeHive.fromMap(Map<String, dynamic> map) {
    return TypeHive(
      id: map['id'],
      name: map['name'],
      createdAt:
          DateTime.parse(map['created_at']), // Convertendo de string ISO 8601
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
  String tipeHivesAsStringByName() {
    return name;
  }
}
