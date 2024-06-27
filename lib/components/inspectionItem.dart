import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/inspection.dart';
import '../routes/appRoute.dart';

class InspectionItem extends StatelessWidget {
  final Inspection inspection;

  const InspectionItem(this.inspection);
/*
  void _selectInspection(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.APIARY_DETAILS,
      arguments: specie,
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*Navigator.of(context).pushNamed(
          AppRoutes.APIARY_DETAILS,
          arguments: inspections,
        );*/
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inspection.id.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
              Text(
                inspection.typeInspectionId.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Característica do Mel: Doce',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
