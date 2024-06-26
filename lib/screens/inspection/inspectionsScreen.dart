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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InspectionProvider>(context, listen: false)
          .loadInspectionsScreen();
    });
  }

  Widget build(BuildContext context) {
    final InspectionProvider inspections = Provider.of(context);
    final inspectionsList = inspections.inspection; // Obter a lista de apiários
    final inspectionsScreen = inspections.inspectionsScreen;

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
        children: inspectionsScreen.map((api) {
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
