import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/floralResource.dart';
import 'package:app_bee/models/hive.dart';

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
  final int cityId;
  final int stateId;
  final List<FloralResource>
      floralResources; // Adiciona a lista de FloralResources
  final List<Hive> hives;
  final DateTime createdAt;
  final DateTime? updatedAt;
  // final String biome;

  Apiary({
    required this.id,
    required this.name,
    required this.cityId,
    required this.stateId,
    this.floralResources = const [],
    this.hives = const [],
    required this.createdAt,
    this.updatedAt,
    //required this.biome,
  });

  Apiary copyWith({
    int? id,
    String? name,
    int? cityId,
    int? stateId,
    List<FloralResource>? floralResources,
    List<Hive>? hives,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Apiary(
      id: id ?? this.id,
      name: name ?? this.name,
      cityId: cityId ?? this.cityId,
      stateId: stateId ?? this.cityId,
      floralResources: floralResources ?? this.floralResources,
      hives: hives ?? this.hives,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city_id': cityId,
      'state_id': stateId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Apiary.fromMap(Map<String, dynamic> map) {
    return Apiary(
      id: map['id'],
      name: map['name'],
      cityId: map['city_id'],
      stateId: map['state_id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
