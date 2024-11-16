import 'package:app_bee/components/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/typeInspectionItem.dart';

class TypesInspectionsScreen extends StatefulWidget {
  @override
  State<TypesInspectionsScreen> createState() => TypesInspectionsScreenState();
}

class TypesInspectionsScreenState extends State<TypesInspectionsScreen> {
  Widget build(BuildContext context) {
    final TypeInspectionProvider typesInspections = Provider.of(context);
    final typesInspectionsList =
        typesInspections.typeInspection; // Obter a lista de apiários
    return Scaffold(
      appBar: AppBar(
        title: Text("Tipos de Inspeções"),
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
        children: typesInspectionsList.map((api) {
          return TypeInspectionItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.TYPE_INSPECTION_FORM);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
