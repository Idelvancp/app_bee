import 'dart:math';
import 'package:app_bee/models/typeHive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/honeyBox.dart';
import 'package:app_bee/database/honeyBoxesDatabaseHelper.dart';

class HoneyBoxProvider with ChangeNotifier {
  List<HoneyBox> _honeyBoxes = [];

  List<HoneyBox> get honeyBoxe => [..._honeyBoxes];
  List<HoneyBoxWithTypeName> _honeyBoxesWithTypeName = [];
  List<HoneyBoxWithTypeName> get honeyBoxesWithTypeName =>
      _honeyBoxesWithTypeName;
  int get honeyBoxesCount {
    return _honeyBoxes.length;
  }

  Future<void> loadHoneyBoxes() async {
    final honeyBoxes = await honeyBoxDatabase().getHoneyBoxes();
    _honeyBoxes = honeyBoxes;
    notifyListeners();
  }

  Future<void> loadHoneyBoxestoForm() async {
    _honeyBoxesWithTypeName =
        await honeyBoxDatabase().getHoneyBoxesWithTypeNames();
    honeyBoxesWithTypeName.forEach((item) {});
    notifyListeners();
  }

  void addHoneyBoxFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newHoneyBox = HoneyBox(
      id: Random().nextInt(10000),
      tag: data['tag'].toString(),
      busy: data['busy'] == false ? 0 as int : 1 as int,
      numberFrames: data['numberFrames'] as int,
      busyFrames: data['busyFrames'] as int,
      typeHiveId: data['typeHiveId'] as int,
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addHoneyBox(newHoneyBox);
  }

  Future<void> addHoneyBox(HoneyBox honeyBox) async {
    /* final honeyBoxes = await DatabaseHelper().getHoneyBoxes();
    honeyBoxes.forEach((item) {
      print(item.busyFrames);
    });*/
    _honeyBoxes.add(honeyBox);
    await honeyBoxDatabase().insertHoneyBox(honeyBox);
    notifyListeners();
  }
}
