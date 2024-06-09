import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/models/floralResources.dart';
import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';

class ApiaryForm2 extends StatefulWidget {
  final String name;
  final String date;
  final String location;

  ApiaryForm2({required this.name, required this.date, required this.location});

  @override
  _ApiaryForm2State createState() => _ApiaryForm2State();
}

class _ApiaryForm2State extends State<ApiaryForm2> {
  List dropdownBiome = Biome.values.toList();
  FloralResources? selectedResource;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recursos Florais"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [],
          ),
        ),
      ),
    );
  }
}
