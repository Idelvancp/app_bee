import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/providers/collectProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/providers/hiveProvider.dart';

class ApiaryDetailsScreen extends StatefulWidget {
  const ApiaryDetailsScreen({Key? key}) : super(key: key);

  @override
  _ApiaryDetailsScreenState createState() => _ApiaryDetailsScreenState();
}

class _ApiaryDetailsScreenState extends State<ApiaryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Apiary apiary =
            ModalRoute.of(context)!.settings.arguments as Apiary;
        Provider.of<CollectProvider>(context, listen: false)
            .loadCollectsForApiary(apiary.id!);
        Provider.of<HiveProvider>(context, listen: false)
            .loadIsnpectionsHives();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Apiary apiaryData =
        ModalRoute.of(context)?.settings.arguments as Apiary;

    print("Dados ${apiaryData.id}");
    List floralResources = apiaryData.floralResources;
    String floralResourcesText = floralResources.map((e) => e.name).join(', ');
    final HiveProvider hives = Provider.of(context);
    final hivesInspections = hives.inspectionsHives;
    List<dynamic> filteredInspections = hivesInspections.where((inspection) {
      return inspection['apiary_id'] == apiaryData.id;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Apiário: ${apiaryData.name}"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Consumer<CollectProvider>(
        builder: (context, provider, child) {
          var honeyTotals = provider.getTotalHoneyByYearByApiary();
          var propolisTotals = provider.getTotalPropolisByYear();
          var waxTotals = provider.getTotalWaxByYear();
          var royalJellyTotals = provider.getTotalRoyalJellyByYear();
          var maxHoneyByYear = provider.getMaxHoneyByYear();
          var maxPropolisByYear = provider.getMaxPropolisByYear();
          var maxWaxByYear = provider.getMaxWaxByYear();
          var maxRoyalJellyByYear = provider.getMaxRoyalJellyByYear();

          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              _buildApiaryInfoCard(apiaryData, floralResourcesText),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Colméias com Alerta:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ..._buildInspectionsAlerts(filteredInspections),
              _buildProductionCard("Produção de Mel por Ano", honeyTotals),
              _buildProductionCard(
                  "Produção de Própolis por Ano", propolisTotals),
              _buildProductionCard("Produção de Cera por Ano", waxTotals),
              _buildProductionCard(
                  "Produção de Geleia Real por Ano", royalJellyTotals),
              _buildMaxProductionCard(
                  "Maior Produção de Mel por Ano", maxHoneyByYear, 'honey'),
              _buildMaxProductionCard("Maior Produção de Própolis por Ano",
                  maxPropolisByYear, 'propolis'),
              _buildMaxProductionCard(
                  "Maior Produção de Cera por Ano", maxWaxByYear, 'wax'),
              _buildMaxProductionCard("Maior Produção de Geleia Real por Ano",
                  maxRoyalJellyByYear, 'royal_jelly'),

              // Adicionar um botão para navegar para a tela HivesScreen
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.HIVES_INDEX,
                      arguments: apiaryData.id,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.purple,
                  ),
                  child: Text(
                    "Visualizar Colmeias",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para adicionar nova inspeção
          //Navigator.of(context).pushNamed(AppRoutes.NEW_INSPECTION_FORM, arguments: apiaryData);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Widget _buildApiaryInfoCard(Apiary apiary, String floralResources) {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.business, color: Colors.purple),
              title: Text("Nome do Apiário"),
              subtitle: Text(apiary.name),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.purple),
              title: Text("Localização"),
              subtitle: Text("Francinópolis-Piauí"),
              //subtitle: Text("${apiary.cityId}, ${apiary.stateId}"),
            ),
            ListTile(
              leading: Icon(Icons.local_florist, color: Colors.purple),
              title: Text("Recursos Florais"),
              subtitle: Text(floralResources),
            ),
            ListTile(
              leading: Icon(Icons.home_work, color: Colors.purple),
              title: Text("Quantidade de Colmeias"),
              subtitle: Text("${apiary.hives.length}"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductionCard(String title, Map<int, double> data) {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          //leading: Icon(Icons.local_dining, color: Colors.purple),
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.entries
                .map((entry) =>
                    Text("${entry.key}: ${entry.value.toStringAsFixed(2)} kg"))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildMaxProductionCard(
      String title, Map<int, dynamic> data, String key) {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          //leading: Icon(Icons.star, color: Colors.purple),
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.entries
                .map((entry) => Text(
                    "${entry.key}: ${entry.value[key].toStringAsFixed(2)} kg - Caixa: ${entry.value['tag']} - Especie: ${entry.value['specie']}"))
                .toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInspectionsAlerts(List<dynamic> filteredInspections) {
    return filteredInspections.where((table) {
      return table?['larvae_health_development'] == "Doente" ||
          table?['larvae_health_development'] == "Morta" ||
          table?['larvae_presence_distribution'] == "Irregular" ||
          table?['larvae_presence_distribution'] == "Ausente" ||
          table?['pupa_health_development'] == "Morta" ||
          table?['pupa_health_development'] == "Doente" ||
          table?['pupa_presence_distribution'] == "Irregular" ||
          table?['pupa_presence_distribution'] == "Ausente";
    }).map((table) {
      return Card(
        color: Colors.yellow[50],
        child: ListTile(
          leading: Icon(Icons.warning, color: Colors.red),
          title: Text("Inspeção em ${table['tag']}"),
          subtitle: Text(
              "Abelhas: ${table['number_bees']}, Larvas: ${table['larvae_health_development']}, Pupas: ${table['pupa_health_development']}"),
        ),
      );
    }).toList();
  }
}
