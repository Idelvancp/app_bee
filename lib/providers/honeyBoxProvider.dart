import 'dart:math';
import 'package:app_bee/models/typeHive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/honeyBox.dart';
import 'package:app_bee/database/databaseHelper.dart';

class HoneyBoxProvider with ChangeNotifier {
  final List<HoneyBox> _honeyBoxes = [];
  List<HoneyBox> get honeyBox => [..._honeyBoxes];

  int get honeyBoxesCount {
    return _honeyBoxes.length;
  }

  void loadHoneyBoxes() async {
    final honeyBoxes = await DatabaseHelper().getHoneyBoxes();
    _honeyBoxes.clear();
    _honeyBoxes.addAll(honeyBoxes);
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
    print('___________________');
    print(newHoneyBox);
    addHoneyBox(newHoneyBox);
  }

  Future<void> addHoneyBox(HoneyBox honeyBox) async {
    _honeyBoxes.add(honeyBox);
    await DatabaseHelper().insertHoneyBox(honeyBox);
    notifyListeners();
  }
}
