import 'package:app_bee/components/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/inspectionItem.dart';

class InspectionsScreen extends StatefulWidget {
  @override
  State<InspectionsScreen> createState() => InspectionsScreenState();
}

class InspectionsScreenState extends State<InspectionsScreen> {
  Widget build(BuildContext context) {
    final InspectionProvider inspections = Provider.of(context);
    final inspectionsList = inspections.inspection; // Obter a lista de apiários
    return Scaffold(
      appBar: AppBar(
        title: Text("Inspeções"),
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
        children: inspectionsList.map((api) {
          return InspectionItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.INSPECTION_FORM);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
