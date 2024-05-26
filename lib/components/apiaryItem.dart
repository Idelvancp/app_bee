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
    final apiaryHives = DUMMY_HIVES.where((hive) {
      return hive.apiaryId == apiary.id;
    }).toList();
    return InkWell(
      onTap: () => _selectApiary(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        child: Row(children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2)),
            padding: EdgeInsets.all(10),
            child: Text(
              '${apiary.biome.toString()}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${apiary.biome.toString()}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${apiaryHives.length}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
