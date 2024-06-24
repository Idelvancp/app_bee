import 'dart:ffi';
import 'dart:math';
import 'package:app_bee/models/populationData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/inspection.dart';
import 'package:app_bee/models/environmentData.dart';
import 'package:app_bee/models/products.dart';
import 'package:app_bee/database/inspectionDataBase.dart';

class InspectionProvider with ChangeNotifier {
  final List<Inspection> _inspections = [];
  List<Inspection> get inspection => [..._inspections];

  int get inspectionsCount {
    return _inspections.length;
  }

  void loadInspections() async {
    final inspections = await InspectionDatabase().getInspections();
    _inspections.clear();
    _inspections.addAll(inspections);
    notifyListeners();
  }

  void addInspectionFromData(Map<String, dynamic> data) {
    print("Etou no Provider kkkkkkkkkkkkkkkkkkk ${data['amountPropolis']}");
    final now = DateTime.now();
    final newInspection = Inspection(
      id: Random().nextInt(10000),
      date: now,
      hiveId: data['hiveId'] as int,
      typeInspectionId: data['typeInspectionId'] as String,
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );

    final newPopulationData = PopulationData(
      id: Random().nextInt(10000),
      numberBees: data['numberBees'] as int,
      ageQueen: data['ageQueen'] as double,
      spawningQueen: data['spawningQueen'] as String,
      larvaePresenceDistribution: data['larvaePresenceDistribution'] as String,
      larvaeHealthDevelopment: data['larvaeHealthDevelopment'] as String,
      pupaPresenceDistribution: data['pupaPresenceDistribution'] as String,
      pupaHealthDevelopment: data['pupaHealthDevelopment'] as String,
    );

    final newEnvironmentData = EnvironmentData(
      id: Random().nextInt(10000),
      internalTemperature: data['internalTemperature'] as double,
      externalTemperature: data['externalTemperature'] as double,
      internalHumidity: data['internalHumidity'] as int,
      externalHumidity: data['externalHumidity'] as int,
      windSpeed: data['windSpeed'] as int,
    );

    final newProduct = Product(
      id: Random().nextInt(10000),
      amountHoney: data['amountHoney'] as double,
      amountPropolis: data['amountPropolis'] as double,
      amountWax: data['amountWax'] as double,
      amountRoyalJelly: data['amountRoyalJelly'] as double,
    );

    addInspection(
        newInspection, newPopulationData, newEnvironmentData, newProduct);
  }

  Future<void> addInspection(Inspection inspection, PopulationData population,
      EnvironmentData environment, Product product) async {
    _inspections.add(inspection);
    await InspectionDatabase()
        .insertInspection(inspection, population, environment, product);
    notifyListeners();
  }
}
