import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_bee/routes/appRoute.dart';

class HiveDetailsScreen extends StatelessWidget {
  const HiveDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Map<String, dynamic> hive = arguments['hive'] as Map<String, dynamic>;
    final Map<String, dynamic>? inspections =
        arguments['inspections'] as Map<String, dynamic>?;

    print("Hive: ${hive}");
    print("Inspections: ${inspections}");
    final dateFormat = DateFormat('dd-MM-yyyy');
    String formattedDate =
        dateFormat.format(DateTime.parse(inspections?['date']));

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
        title: Text("Detalhes da Colmeia"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text("Caixa: ${inspections?['tag']}", style: titleStyle),
              subtitle: Text("Data: $formattedDate", style: subtitleStyle),
            ),
            Divider(),
            ListTile(
              title: Text(
                  "Tipo de Inspeção: ${inspections?['type_inspection_id']}",
                  style: titleStyle),
              subtitle: Text("Data: $formattedDate", style: subtitleStyle),
            ),
            Divider(),
            ListTile(
              title: Text("Detalhes da População", style: titleStyle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Número de abelhas: ${inspections?['number_bees']}",
                      style: subtitleStyle),
                  Text("Idade da rainha: ${inspections?['age_queen']}",
                      style: subtitleStyle),
                  Text("Postura da rainha: ${inspections?['spawning_queen']}",
                      style: subtitleStyle),
                  Text(
                      "Distribuição de larvas: ${inspections?['larvae_presence_distribution']}",
                      style: subtitleStyle),
                  Text(
                      "Desenvolvimento de larvas: ${inspections?['larvae_health_development']}",
                      style: subtitleStyle),
                  Text(
                      "Distribuição de pupas: ${inspections?['pupa_presence_distribution']}",
                      style: subtitleStyle),
                  Text(
                      "Desenvolvimento de pupas: ${inspections?['pupa_health_development']}",
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
                      "Temperatura Interna: ${inspections?['internal_temperature']}°C",
                      style: subtitleStyle),
                  Text(
                      "Temperatura Externa: ${inspections?['external_temperature']}°C",
                      style: subtitleStyle),
                  Text("Umidade Interna: ${inspections?['internal_humidity']}%",
                      style: subtitleStyle),
                  Text("Umidade Externa: ${inspections?['external_humidity']}%",
                      style: subtitleStyle),
                  Text(
                      "Velocidade do Vento: ${inspections?['wind_speed']} km/h",
                      style: subtitleStyle),
                ],
              ),
            ),
            Divider(),
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
    );

/*
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
    */
  }
}
