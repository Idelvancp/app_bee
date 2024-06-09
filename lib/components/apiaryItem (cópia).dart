import 'package:flutter/material.dart';
import '../models/apiary.dart';
import '../routes/appRoute.dart';
import '../data/dummy_data.dart';

class ApiaryItem extends StatelessWidget {
  final Apiary apiary;

  const ApiaryItem(this.apiary);

  void _selectApiary(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.APIARY_DETAILS,
      arguments: apiary,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int alerts = 3;
    final apiaryHives = DUMMY_HIVES.where((hive) {
      return hive.apiaryId == apiary.id;
    }).toList();
    return InkWell(
      onTap: () => _selectApiary(context),
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
                "Apiário Campestre",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Quantidade de Colmeias: 15',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Alertas: $alerts',
                style: TextStyle(
                  fontSize: 16,
                  color: alerts > 0 ? Colors.red : Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
