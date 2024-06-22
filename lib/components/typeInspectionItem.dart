import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:flutter/material.dart';
import '../models/typeInspection.dart';
import '../routes/appRoute.dart';

class TypeInspectionItem extends StatelessWidget {
  final TypeInspection typeInspection;

  const TypeInspectionItem(this.typeInspection);

  void _selectTypeInspection(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.APIARY_DETAILS,
      arguments: typeInspection,
    );
  }

  @override
  Widget build(BuildContext context) {
    final typesInspections = TypeInspectionProvider().loadTypeInspections();
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.APIARY_DETAILS,
          arguments: typeInspection,
        );
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
                typeInspection.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Quantidade de Colmeias da Espécie: 5',
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
