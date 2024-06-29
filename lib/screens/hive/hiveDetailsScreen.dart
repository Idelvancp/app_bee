import 'package:flutter/material.dart';
import 'package:app_bee/routes/appRoute.dart';

class HiveDetailsScreen extends StatelessWidget {
  const HiveDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> hive =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    void _toInspection(BuildContext context) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.INSPECTION_FORM,
        (Route<dynamic> route) => false,
        arguments: hive,
      );
    }

    void _toCollect(BuildContext context) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.COLLECT_FORM,
        (Route<dynamic> route) => false,
        arguments: hive,
      );
    }

    TextStyle titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );

    TextStyle subtitleStyle = TextStyle(
      fontSize: 16,
      color: Colors.black54,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhe Colmeia"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Apiário: ${hive['apiary_name']}', style: titleStyle),
            ),
            ListTile(
              title: Text('Created At: ${hive['created_at']}',
                  style: subtitleStyle),
            ),
            ListTile(
              title: Text('Updated At: ${hive['updated_at']}',
                  style: subtitleStyle),
            ),
            ListTile(
              title: Text('Espécie: ${hive['specie_name']}', style: titleStyle),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () => _toInspection(context),
              child: Text('Adicionar Inspeção'),
            ),
            ElevatedButton(
              onPressed: () => _toCollect(context),
              child: Text('Adicionar Coleta'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.APIARY_FORM);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
