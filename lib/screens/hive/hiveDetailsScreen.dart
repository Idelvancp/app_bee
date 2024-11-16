import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/collectProvider.dart';

class HiveDetailsScreen extends StatefulWidget {
  const HiveDetailsScreen({Key? key}) : super(key: key);

  @override
  _HiveDetailsScreenState createState() => _HiveDetailsScreenState();
}

class _HiveDetailsScreenState extends State<HiveDetailsScreen> {
  Map<String, dynamic>? hive;
  Map<String, dynamic>? inspections;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hive == null) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      hive = arguments['hive'] as Map<String, dynamic>;
      inspections = arguments['inspections'] as Map<String, dynamic>?;

      Provider.of<CollectProvider>(context, listen: false)
          .loadSumProductsByHive(hive!['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CollectProvider collect = Provider.of(context);
    final productsHive = collect.sumProductsByHive;
    print(productsHive);

    // Formatar a data no formato "dia-mês-ano-hora-minuto"
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    String formattedDate = inspections != null && inspections!['date'] != null
        ? dateFormat.format(DateTime.parse(inspections!['date']))
        : dateFormat.format(DateTime.now());

    void _toInspection(BuildContext context) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.INSPECTIONS_SCREEN,
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
            ),
            Divider(),
            ListTile(
              title: Text(
                  "Útima Inspeção: ${inspections?['type_inspection_id']}",
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
            ListTile(
              title: Text("Total de Produtos da Colmeia", style: titleStyle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mel:  ${productsHive['total_honey']}kg",
                      style: subtitleStyle),
                  Text("Própolis:  ${productsHive['total_propolis']}kg",
                      style: subtitleStyle),
                  Text("Cera:  ${productsHive['total_wax']}kg",
                      style: subtitleStyle),
                  Text("Geléia Real:  ${productsHive['total_royal_jelly']}kg",
                      style: subtitleStyle),
                ],
              ),
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
    );
  }
}
