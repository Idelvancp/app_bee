import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/dummy_data.dart';
import '../../components/apiaryItem.dart';
import 'dart:math';

class ApiariesScreen extends StatefulWidget {
  @override
  State<ApiariesScreen> createState() => ApiariesScreenState();
}

class ApiariesScreenState extends State<ApiariesScreen> {
  _addApiary(String name, int cityId, Biome biome) {
    final newApiary = Apiary(
      id: Random().nextInt(1000).toInt(),
      name: name,
      cityId: cityId,
      biome: biome,
    );

    setState(() {
      DUMMY_APIARIES.add(newApiary);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: DUMMY_APIARIES.map((api) {
          return ApiaryItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.APIARY_FORM);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
