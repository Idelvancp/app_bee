import 'dart:ffi';
import 'dart:math';
import 'package:app_bee/models/populationData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/inspection.dart';
import 'package:app_bee/models/environmentData.dart';
import 'package:app_bee/models/collect.dart';
import 'package:app_bee/database/inspectionsDatabaseHelper.dart';

class InspectionProvider with ChangeNotifier {
  final List<Inspection> _inspections = [];
  List<Inspection> get inspection => [..._inspections];
  final List _apiaryInspections = [];

  final List _inspectionsScreen = [];
  List get inspectionsScreen => [..._inspectionsScreen];
  List get apiaryInspections => [..._apiaryInspections];
  int get inspectionsCount {
    return _inspections.length;
  }

  final List _lastInspectionsHives = [];
  List get lastInspectionsHives => [..._lastInspectionsHives];

  void loadInspections() async {
    final inspections = await InspectionDatabase().getInspections();
    _inspections.clear();
    _inspections.addAll(inspections);
    notifyListeners();
  }

  void loadInspectionsScreen() async {
    final inspectionsScreen = await InspectionDatabase().getInspectionScreen();
    _inspectionsScreen.clear();
    _inspectionsScreen.addAll(inspectionsScreen);

    inspectionsScreen.forEach((table) {
      print(
          'Dados da Inspeçãofsdgsdfgsdf ${table['tag']}, ${table['age_queen']}, ${table['number_bees']}');
    });
    notifyListeners();
  }

  // Carregar inspeções de um apiário específico
  Future<void> loadInspectionsForApiary(int apiaryId) async {
    final apiaryInspections =
        await InspectionDatabase().hivesInspections(apiaryId);
    print("Loaded inspections: $apiaryInspections");
    _apiaryInspections.clear();
    _apiaryInspections.addAll(apiaryInspections);
    notifyListeners();
  }

  void addInspectionFromData(Map<String, dynamic> data) {
    final now = DateTime.now();
    final newInspection = Inspection(
      date: DateTime.parse(data['date'].toString()),
      hiveId: data['hiveId'] as int,
      typeInspectionId: data['typeInspectionId'] as String,
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );

    final newPopulationData = PopulationData(
      numberBees: data['numberBees'] as int,
      ageQueen: data['ageQueen'] as double,
      spawningQueen: data['spawningQueen'] as String,
      larvaePresenceDistribution: data['larvaePresenceDistribution'] as String,
      larvaeHealthDevelopment: data['larvaeHealthDevelopment'] as String,
      pupaPresenceDistribution: data['pupaPresenceDistribution'] as String,
      pupaHealthDevelopment: data['pupaHealthDevelopment'] as String,
    );

    final newEnvironmentData = EnvironmentData(
      internalTemperature: data['internalTemperature'] as double,
      externalTemperature: data['externalTemperature'] as double,
      internalHumidity: data['internalHumidity'] as int,
      externalHumidity: data['externalHumidity'] as int,
      windSpeed: data['windSpeed'] as int,
    );

    print("Adding inspection: $newInspection");
    print("With population data: $newPopulationData");
    print("With environment data: $newEnvironmentData");
    addInspection(newInspection, newPopulationData, newEnvironmentData);
  }

  Future<void> addInspection(Inspection inspection, PopulationData population,
      EnvironmentData environment) async {
    _inspections.add(inspection);
    await InspectionDatabase()
        .insertInspection(inspection, population, environment);
    notifyListeners();
  }

  Map<int, double> getTotalHoneyByYear() {
    Map<int, double> totals = {};
    for (var inspection in _apiaryInspections) {
      int year = DateTime.parse(inspection['date']).year;
      totals[year] = (totals[year] ?? 0) + (inspection['honey'] as double);
    }
    return totals;
  }

  Map<int, double> getTotalPropolisByYear() {
    Map<int, double> totals = {};
    for (var inspection in _apiaryInspections) {
      int year = DateTime.parse(inspection['date']).year;
      totals[year] = (totals[year] ?? 0) + (inspection['propolis'] as double);
    }
    return totals;
  }

  Map<int, double> getTotalWaxByYear() {
    Map<int, double> totals = {};
    for (var inspection in _apiaryInspections) {
      int year = DateTime.parse(inspection['date']).year;
      totals[year] = (totals[year] ?? 0) + (inspection['wax'] as double);
    }
    return totals;
  }

  Map<int, double> getTotalRoyalJellyByYear() {
    Map<int, double> totals = {};
    for (var inspection in _apiaryInspections) {
      int year = DateTime.parse(inspection['date']).year;
      totals[year] =
          (totals[year] ?? 0) + (inspection['royal_jelly'] as double);
    }
    return totals;
  }
/*
  void loadLastInspectionsHives() async {
    final inspections =
        await InspectionDatabase().getHivesWithLatestInspection();
    _lastInspectionsHives.clear();
    _lastInspectionsHives.addAll(inspections);
    /* inspections.forEach((table) {
      print('Hive ID: ${table['id']}');
      print('Last Inspection Date: ${table['date']}');
      // Aqui você pode acessar os dados da população através de 'p.*'
      print(
          'Population Data ID: ${table['spawning_queen']}'); // Exemplo de como acessar o ID da população
    });*/
    notifyListeners();
  }
  */
}
