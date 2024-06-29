import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:app_bee/routes/appRoute.dart';

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
        Provider.of<InspectionProvider>(context, listen: false)
            .loadInspectionsForApiary(apiary.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Apiary apiaryData =
        ModalRoute.of(context)?.settings.arguments as Apiary;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Apiário: ${apiaryData.name}"),
        centerTitle: true,
      ),
      body: Consumer<InspectionProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              ListTile(
                title: Text("Nome do Apiário"),
                subtitle: Text(apiaryData.name),
                leading: Icon(Icons.business),
              ),
              ListTile(
                title: Text("Localização"),
                subtitle: Text("${apiaryData.cityId}, ${apiaryData.stateId}"),
                leading: Icon(Icons.location_on),
              ),
              ListTile(
                title: Text("Recursos Florais"),
                subtitle: Text(apiaryData.floralResources.join(', ')),
                leading: Icon(Icons.local_florist),
              ),
              ListTile(
                title: Text("Quantidade de Colmeias"),
                subtitle: Text("${apiaryData.hives.length}"),
                leading: Icon(Icons.home_work),
              ),
              ListTile(
                title: Text("Total de Mel"),
                subtitle:
                    Text("${provider.getTotalHoney().toStringAsFixed(2)} kg"),
                leading: Icon(Icons.local_drink),
              ),
              ListTile(
                title: Text("Total de Própolis"),
                subtitle: Text(
                    "${provider.getTotalPropolis().toStringAsFixed(2)} kg"),
                leading: Icon(Icons.local_florist),
              ),
              ListTile(
                title: Text("Total de Cera"),
                subtitle:
                    Text("${provider.getTotalWax().toStringAsFixed(2)} kg"),
                leading: Icon(Icons.texture),
              ),
              ListTile(
                title: Text("Total de Geleia Real"),
                subtitle: Text(
                    "${provider.getTotalRoyalJelly().toStringAsFixed(2)} kg"),
                leading: Icon(Icons.eco),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Inspeções:",
                ),
              ),
              ...provider.apiaryInspections.map((inspection) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: ExpansionTile(
                    leading: Icon(Icons.search),
                    title: Text(
                        "Inspeção em ${inspection['date']} - ${inspection['type_inspection_name']}"),
                    children: <Widget>[
                      ListTile(
                        title: Text("Detalhes da População"),
                        subtitle: Text(
                            "Abelhas: ${inspection['number_bees']}, Idade da rainha: ${inspection['age_queen']}"),
                      ),
                      ListTile(
                        title: Text("Dados Ambientais"),
                        subtitle: Text(
                            "Temp. Interna: ${inspection['internal_temperature']}°C, Umidade: ${inspection['internal_humidity']}%"),
                      ),
                      ListTile(
                        title: Text("Produtos Coletados"),
                        subtitle: Text(
                            "Mel: ${inspection['honey']} kg, Cera: ${inspection['wax']} kg"),
                      ),
                      ListTile(
                        title: Text("Observações"),
                        subtitle: Text(
                            "${inspection['notes'] ?? 'Nenhuma observação adicional.'}"),
                      ),
                    ],
                  ),
                );
              }).toList()
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
        backgroundColor: Colors.green,
      ),
    );
  }
}
