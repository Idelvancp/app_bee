import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/providers/apiaryProvider.dart';
import 'package:app_bee/components/apiaryItem.dart';
import 'package:app_bee/providers/expenseProvider.dart';
import 'package:app_bee/providers/hiveProvider.dart';

class ApiariesScreen extends StatefulWidget {
  @override
  State<ApiariesScreen> createState() => ApiariesScreenState();
}

class ApiariesScreenState extends State<ApiariesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApiaryProvider>(context, listen: false)
          .fetchAndPrintApiaries();
      Provider.of<HiveProvider>(context, listen: false).loadIsnpectionsHives();
    });
  }

  Widget build(BuildContext context) {
    final ApiaryProvider apiaries = Provider.of(context);
    final HiveProvider hives = Provider.of(context);

    final apiariesList = apiaries.apiary;
    final hivesInspections = hives.isnpectionsHives;

    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: apiariesList.map((api) {
          var inspectionData = hivesInspections.firstWhere(
            (insp) => insp['apiary_id'] == api.id,
            orElse: () =>
                <String, dynamic>{}, // Return an empty map instead of null
          );
          return ApiaryItem(api, inspections: inspectionData);
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
