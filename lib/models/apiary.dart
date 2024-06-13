import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/floralResource.dart';

enum Biome {
  amazonia,
  caatinga,
  cerrado,
  mataAtlantica,
  pantanal,
  pampa,
}

class Apiary with ChangeNotifier, DiagnosticableTreeMixin {
  final int id;
  final String name;
  final List<FloralResource>
      floralResources; // Adiciona a lista de FloralResources
  final DateTime createdAt;
  final DateTime? updatedAt;
  // final String biome;

  Apiary({
    required this.id,
    required this.name,
    this.floralResources = const [],
    required this.createdAt,
    this.updatedAt,
    //required this.biome,
  });

  Apiary copyWith({
    int? id,
    String? name,
    List<FloralResource>? floralResources,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Apiary(
      id: id ?? this.id,
      name: name ?? this.name,
      floralResources: floralResources ?? this.floralResources,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Apiary.fromMap(Map<String, dynamic> map) {
    return Apiary(
      id: map['id'],
      name: map['name'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
