import 'package:provider/provider.dart';
import 'package:app_bee/providers/hiveProvider.dart';
import 'package:flutter/material.dart';
import '../models/hive.dart';
import '../routes/appRoute.dart';
import 'package:app_bee/providers/inspectionProvider.dart';

class HiveItem extends StatelessWidget {
  final Map<String, dynamic> hive;
  final Map<String, dynamic>? inspections;

  const HiveItem(this.hive, {this.inspections});

  void _selectHive(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.HIVE_DETAILS, arguments: {
      'hive': hive,
      'inspections': inspections,
    });
  }

  @override
  Widget build(BuildContext context) {
    final hives = HiveProvider().loadHives();
    return InkWell(
      onTap: () => _selectHive(context),
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
                    'Tag: ${hive['honey_box_tag'].toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  if (inspections?['larvae_health_development'] == "Doente" ||
                      inspections?['larvae_health_development'] == "Morta" ||
                      inspections?['larvae_presence_distribution'] ==
                          "Irregular" ||
                      inspections?['larvae_presence_distribution'] ==
                          "Ausente" ||
                      inspections?['pupa_health_development'] == "Morta" ||
                      inspections?['pupa_health_development'] == "Doente" ||
                      inspections?['pupa_presence_distribution'] ==
                          "Irregular" ||
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
              Text(
                'Apiário: ${hive['apiary_name']}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Espécie: ${hive['specie_name']} ',
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
