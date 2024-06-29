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
      Provider.of<HiveProvider>(context, listen: false).loadHivesDetails();
      Provider.of<InspectionProvider>(context, listen: false)
          .loadLastInspectionsHives();
    });
  }

  Widget build(BuildContext context) {
    final HiveProvider hives = Provider.of(context);
    final hivesList = hives.hive;
    final detail = hives.hiveDetail;
    final inspectionProvider = Provider.of<InspectionProvider>(context);
    final List<dynamic> lastInspectionsHives =
        inspectionProvider.lastInspectionsHives;

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
        children: lastInspectionsHives.map((api) {
          return HiveItem(api);
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
