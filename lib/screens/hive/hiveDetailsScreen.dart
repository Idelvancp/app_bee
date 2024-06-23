import 'package:app_bee/data/dummy_data.dart';
import 'package:app_bee/models/hive.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/routes/appRoute.dart';
import '../../components/hiveItem.dart';
import 'package:app_bee/providers/hiveProvider.dart';

class HiveDetailsScreen extends StatelessWidget {
  const HiveDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> hive =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    void _selectHive(BuildContext context) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.INSPECTION_FORM,
        (Route<dynamic> route) => false, // Remove todas as telas anteriores
        arguments: hive,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhe Colmeia"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apiário: ${hive['apiary_name']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Created At: ${hive['created_at']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text('Updated At: ${hive['updated_at']}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Espécie: ${hive['specie_name']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () => _selectHive(context),
              child: Text('Adicionar Inspeção'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.APIARY_FORM);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
