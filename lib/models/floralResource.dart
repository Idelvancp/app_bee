import 'package:flutter/material.dart';

class FloralResource with ChangeNotifier {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;

  FloralResource({
    required this.id,
    required this.name,
    required this.createdAt,
    this.updatedAt,
  });

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

  // Converte um Map em um objeto FloralResource
  factory FloralResource.fromMap(Map<String, dynamic> map) {
    return FloralResource(
      id: map['id'],
      name: map['name'],
      createdAt:
          DateTime.parse(map['created_at']), // Convertendo de string ISO 8601
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  String floralResourceAsStringByName() {
    return name;
  }
}
