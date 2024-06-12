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
    /* final apiaryHives = DUMMY_HIVES.where((hive) {
      return hive.apiaryId == apiary.id;
    }).toList();
*/
    // final hives = SpecieProvider().loadSpecies();

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.APIARY_DETAILS,
          arguments: apiary,
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
                "Teste",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Quantidade de Colmeias: 15',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Última vistas: 02/03/2024',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Alertas: $alerts',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
