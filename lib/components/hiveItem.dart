import 'package:app_bee/providers/hiveProvider.dart';
import 'package:flutter/material.dart';
import '../models/hive.dart';
import '../routes/appRoute.dart';

class HiveItem extends StatelessWidget {
  final Hive hive;

  const HiveItem(this.hive);

  void _selectHive(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.APIARY_DETAILS,
      arguments: hive,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hives = HiveProvider().loadHives();
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.APIARY_DETAILS,
          arguments: hive,
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
                "ashfhaksdhk",
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
