import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/routes/appRoute.dart';
import '../../components/hiveItem.dart';
import 'package:app_bee/providers/hiveProvider.dart';
import 'package:app_bee/components/appDrawer.dart';
import 'package:app_bee/providers/inspectionProvider.dart';

class HivesScreen extends StatefulWidget {
  @override
  State<HivesScreen> createState() => HivesScreenState();
}

class HivesScreenState extends State<HivesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HiveProvider>(context, listen: false).loadHives();
      Provider.of<HiveProvider>(context, listen: false).loadIsnpectionsHives();
    });
  }

  Widget build(BuildContext context) {
    final HiveProvider hives = Provider.of(context);
    final hivesList = hives.hivesScreen;
    final detail = hives.hiveDetail;
    final hivesInspections = hives.isnpectionsHives;

    return Scaffold(
      appBar: AppBar(
        title: Text("Colmeias"),
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
        children: hivesList.map((api) {
          // Find matching inspections data for each hive
          var inspectionData = hivesInspections.firstWhere(
            (insp) => insp['hive_id'] == api['id'],
            orElse: () =>
                <String, dynamic>{}, // Return an empty map instead of null
          );

          return HiveItem(api, inspections: inspectionData);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.HIVE_FORM);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
