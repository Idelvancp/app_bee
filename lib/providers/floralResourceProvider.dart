import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/floralResource.dart';
import 'package:app_bee/database/databaseHelper.dart';

class FloralResourceProvider with ChangeNotifier {
  final List<FloralResource> _floralResources = [];
  List<FloralResource> get floralResource => [..._floralResources];

  int get floralResourcesCount {
    return _floralResources.length;
  }

  void loadFloralResources() async {
    final hives = await DatabaseHelper().getFloralResources();
    _floralResources.clear();
    _floralResources.addAll(hives);
    notifyListeners();
  }

  void addFloralResourceFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newFloralResource = FloralResource(
      id: Random().nextInt(10000),
      name: data['name'].toString(),
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addFloralResource(newFloralResource);
  }

  Future<void> addFloralResource(FloralResource floralResource) async {
    _floralResources.add(floralResource);
    await DatabaseHelper().insertFloralResource(floralResource);
    notifyListeners();
  }
}
