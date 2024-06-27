import 'package:app_bee/components/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/specieProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/specieItem.dart';

class SpeciesScreen extends StatefulWidget {
  @override
  State<SpeciesScreen> createState() => SpeciesScreenState();
}

class SpeciesScreenState extends State<SpeciesScreen> {
  Widget build(BuildContext context) {
    final SpecieProvider species = Provider.of(context);
    final speciesList = species.specie; // Obter a lista de apiários
    return Scaffold(
      appBar: AppBar(
        title: Text("Especíes"),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 8 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: speciesList.map((api) {
          return SpecieItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.SPECIE_FORM);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
