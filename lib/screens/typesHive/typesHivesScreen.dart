import 'package:app_bee/components/typeHiveItem.dart';
import 'package:app_bee/models/honeyBox.dart';
import 'package:app_bee/providers/honeyBoxProvider.dart';
import 'package:app_bee/providers/typeHiveProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';

class TypesHivesScreen extends StatefulWidget {
  @override
  State<TypesHivesScreen> createState() => TypesHivesScreenState();
}

class TypesHivesScreenState extends State<TypesHivesScreen> {
  /*
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HoneyBoxProvider>(context, listen: false).fetchHoneyBoxes();
    });
  }
  */

  Widget build(BuildContext context) {
    final TypeHiveProvider typesHives = Provider.of(context);
    final typesHivesList =
        typesHives.typeHive; // Obter a lista de tipos de colmeias
    return Scaffold(
      appBar: AppBar(
        title: Text("Modelos de Colmeias"),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: typesHivesList.map((api) {
          return TypeHiveItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.TYPES_HIVES_FORM);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
