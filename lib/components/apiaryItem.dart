import 'package:flutter/material.dart';
import '../models/apiary.dart';
import '../routes/appRoute.dart';
import 'package:app_bee/models/floralResource.dart';

class ApiaryItem extends StatelessWidget {
  final Apiary apiary;
  final Map<String, dynamic>? inspections;

  const ApiaryItem(this.apiary, {this.inspections});

  void _selectApiary(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.APIARY_DETAILS,
      arguments: apiary,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int maxVisibleResources = 2; // Define o limite de recursos visíveis

    List<FloralResource> visibleResources =
        apiary.floralResources.take(maxVisibleResources).toList();
    List<FloralResource> hiddenResources =
        apiary.floralResources.skip(maxVisibleResources).toList();

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
                apiary.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Recursos Florais: ${visibleResources.map((resource) => resource.name).join(", ")}' +
                    (hiddenResources.isNotEmpty ? ", ..." : ""),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Quantidade de Colméias: ${apiary.hives.length}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              if (inspections?['larvae_health_development'] == "Doente" ||
                  inspections?['larvae_health_development'] == "Morta" ||
                  inspections?['larvae_presence_distribution'] == "Irregular" ||
                  inspections?['larvae_presence_distribution'] == "Ausente" ||
                  inspections?['pupa_health_development'] == "Morta" ||
                  inspections?['pupa_health_development'] == "Doente" ||
                  inspections?['pupa_presence_distribution'] == "Irregular" ||
                  inspections?['pupa_presence_distribution'] == "Ausente")
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
        ),
      ),
    );
  }
}
