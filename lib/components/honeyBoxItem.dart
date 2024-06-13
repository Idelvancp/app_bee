import 'package:app_bee/providers/honeyBoxProvider.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/honeyBox.dart';
import '../routes/appRoute.dart';

class HoneyBoxItem extends StatelessWidget {
  final HoneyBox honeyBox;

  const HoneyBoxItem(this.honeyBox);
/*
  void _selectHoneyBox(BuildContext context) {
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
          arguments: honeyBoxs,
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
                'honeyBox.numberFrames',
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
            ],
          ),
        ),
      ),
    );
  }
}
