import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../routes/appRoute.dart';

class InspectionItem extends StatelessWidget {
  final Map<String, dynamic> inspection;

  const InspectionItem(this.inspection);

  void _selectInspection(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.INSPECTIONS_DETAILS,
      arguments: inspection,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateString = inspection['date'] as String;
    final date = DateTime.parse(dateString);
    final dateFormated = DateFormat('dd-MM-yyyy').format(date);

    return InkWell(
      onTap: () => _selectInspection(context),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data: $dateFormated',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  if (inspection['larvae_health_development'] == "Doente" ||
                      inspection['larvae_health_development'] == "Morta" ||
                      inspection['larvae_presence_distribution'] ==
                          "Irregular" ||
                      inspection['larvae_presence_distribution'] == "Ausente" ||
                      inspection['pupa_health_development'] == "Morta" ||
                      inspection['pupa_health_development'] == "Doente" ||
                      inspection['pupa_presence_distribution'] == "Irregular" ||
                      inspection['pupa_presence_distribution'] == "Ausente")
                    Text(
                      'Alerta !!!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 155, 18, 8),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Caixa: ${inspection['tag'].toString()}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Idade da Rainha: ${inspection['age_queen'].toString()}',
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
