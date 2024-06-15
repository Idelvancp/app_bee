import 'package:app_bee/models/typeHive.dart';
import 'package:flutter/material.dart';

//enum State { goodCondition, poorCondition }

class HoneyBox with ChangeNotifier {
  final int id;
  final String tag;
  final int busy;
  final int numberFrames;
  final int busyFrames;
  final int typeHiveId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  HoneyBox({
    required this.id,
    required this.tag,
    required this.busy,
    required this.numberFrames,
    required this.busyFrames,
    required this.typeHiveId,
    required this.createdAt,
    this.updatedAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tag': tag,
      'busy': busy,
      'number_frames': numberFrames,
      'busy_frames': busyFrames,
      'type_hive_id': typeHiveId,
      'created_at':
          createdAt.toIso8601String(), // Convertendo para string ISO 8601
      'updated_at':
          updatedAt?.toIso8601String(), // Convertendo para string ISO 8601
    };
  }

  // Converte um Map em um objeto HoneyBox
  factory HoneyBox.fromMap(Map<String, dynamic> map) {
    return HoneyBox(
      id: map['id'],
      tag: map['tag'],
      busy: map['busy'],
      numberFrames: map['number_frames'],
      busyFrames: map['busy_frames'],
      typeHiveId: map['type_hive_id'],
      createdAt:
          DateTime.parse(map['created_at']), // Convertendo de string ISO 8601
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}

class HoneyBoxWithTypeName {
  final HoneyBox honeyBox;
  final String typeHiveName;

  HoneyBoxWithTypeName({
    required this.honeyBox,
    required this.typeHiveName,
  });

  // Converte um Map em um objeto HoneyBoxWithTypeName
  factory HoneyBoxWithTypeName.fromMap(Map<String, dynamic> map) {
    return HoneyBoxWithTypeName(
      honeyBox: HoneyBox.fromMap(map),
      typeHiveName: map['name'],
    );
  }
}
