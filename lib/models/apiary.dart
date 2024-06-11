import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'hive.dart';

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
  final String state;
  final String city;
  // final String biome;

  Apiary({
    required this.id,
    required this.name,
    required this.state,
    required this.city,
    //required this.biome,
  });
}
