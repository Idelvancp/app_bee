import 'package:app_bee/providers/floralResourceProvider.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/floralResource.dart';
import '../routes/appRoute.dart';

class FloralResourceItem extends StatelessWidget {
  final FloralResource floralResource;

  const FloralResourceItem(this.floralResource);
/*
  void _selectFloralResource(BuildContext context) {
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
          arguments: floralResources,
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
                floralResource.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Tempo da Flora: Maio a Junho',
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
