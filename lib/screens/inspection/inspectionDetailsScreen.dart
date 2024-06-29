import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/database/databaseHelper.dart';
import 'package:app_bee/models/inspection.dart';

class InspectionDetailsScreen extends StatelessWidget {
  const InspectionDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> inspectionData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Formatação de data
    final dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDate =
        dateFormat.format(DateTime.parse(inspectionData['date']));

    TextStyle titleStyle = TextStyle(
        fontSize: 18, // Tamanho maior
        fontWeight: FontWeight.bold, // Texto em negrito
        color: Colors.black87 // Cor mais escura para maior contraste
        );

    TextStyle subtitleStyle = TextStyle(
        fontSize: 16, // Tamanho adequado para subtexto
        color: Colors.black54 // Cor suave para leitura confortável
        );

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Inspeção"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text("Caixa: ${inspectionData['tag']}", style: titleStyle),
              subtitle: Text("Data: $formattedDate", style: subtitleStyle),
            ),
            Divider(),
            ListTile(
              title: Text(
                  "Tipo de Inspeção: ${inspectionData['type_inspection_id']}",
                  style: titleStyle),
              subtitle: Text("Data: $formattedDate", style: subtitleStyle),
            ),
            Divider(),
            ListTile(
              title: Text("Detalhes da População", style: titleStyle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Número de abelhas: ${inspectionData['number_bees']}",
                      style: subtitleStyle),
                  Text("Idade da rainha: ${inspectionData['age_queen']}",
                      style: subtitleStyle),
                  Text("Postura da rainha: ${inspectionData['spawning_queen']}",
                      style: subtitleStyle),
                  Text(
                      "Distribuição de larvas: ${inspectionData['larvae_presence_distribution']}",
                      style: subtitleStyle),
                  Text(
                      "Desenvolvimento de larvas: ${inspectionData['larvae_health_development']}",
                      style: subtitleStyle),
                  Text(
                      "Distribuição de pupas: ${inspectionData['pupa_presence_distribution']}",
                      style: subtitleStyle),
                  Text(
                      "Desenvolvimento de pupas: ${inspectionData['pupa_health_development']}",
                      style: subtitleStyle),
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Dados Ambientais", style: titleStyle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Temperatura Interna: ${inspectionData['internal_temperature']}°C",
                      style: subtitleStyle),
                  Text(
                      "Temperatura Externa: ${inspectionData['external_temperature']}°C",
                      style: subtitleStyle),
                  Text(
                      "Umidade Interna: ${inspectionData['internal_humidity']}%",
                      style: subtitleStyle),
                  Text(
                      "Umidade Externa: ${inspectionData['external_humidity']}%",
                      style: subtitleStyle),
                  Text(
                      "Velocidade do Vento: ${inspectionData['wind_speed']} km/h",
                      style: subtitleStyle),
                  Text("Nuvens: ${inspectionData['cloud']}",
                      style: subtitleStyle),
                ],
              ),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.INSPECTION_FORM,
                  arguments: inspectionData,
                );
              },
              child: Text('Editar Inspeção'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.APIARY_FORM);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
