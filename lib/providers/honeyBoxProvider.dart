import 'dart:math';
import 'package:app_bee/models/typeHive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/honeyBox.dart';
import 'package:app_bee/database/databaseHelper.dart';

class HoneyBoxProvider with ChangeNotifier {
  List<HoneyBox> _honeyBoxes = [];

  List<HoneyBox> get honeyBoxe => _honeyBoxes;
  List<HoneyBoxWithTypeName> _honeyBoxesWithTypeName = [];
  List<HoneyBoxWithTypeName> get honeyBoxesWithTypeName =>
      _honeyBoxesWithTypeName;
  int get honeyBoxesCount {
    return _honeyBoxes.length;
  }

  Future<void> loadHoneyBoxes() async {
    _honeyBoxesWithTypeName =
        await DatabaseHelper().getHoneyBoxesWithTypeNames();
    honeyBoxesWithTypeName.forEach((item) {
      print(
          'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII${item.honeyBox.busyFrames}');
    });
    notifyListeners();
  }

  void addHoneyBoxFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newHoneyBox = HoneyBox(
      id: Random().nextInt(10000),
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
    await DatabaseHelper().insertHoneyBox(honeyBox);
    notifyListeners();
  }
}
