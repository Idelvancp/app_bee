import 'package:app_bee/providers/specieProvider.dart';
import 'package:flutter/material.dart';
import '../models/specie.dart';
import '../routes/appRoute.dart';

class SpecieItem extends StatelessWidget {
  final Specie specie;

  const SpecieItem(this.specie);

  void _selectSpecie(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.APIARY_DETAILS,
      arguments: specie,
    );
  }

  @override
  Widget build(BuildContext context) {
    final species = SpecieProvider().loadSpecies();
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.APIARY_DETAILS,
          arguments: specie,
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
                specie.name,
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
