import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/database/databaseHelper.dart';

class ApiaryDetailsScreen extends StatelessWidget {
  const ApiaryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Apiary apiaryData =
        ModalRoute.of(context)!.settings.arguments as Apiary;

    // Suponha que esses são os dados formatados retornados pela função
    //  String formattedDate = DateFormat('dd-MM-yyyy')
    //   .format(DateTime.parse(apiaryData['created_at']));

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
        title: Text("Detalhes do Apiário"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text("Nome do Apiário", style: titleStyle),
              subtitle: Text("${apiaryData.name}", style: subtitleStyle),
            ),
            Divider(),
            ListTile(
              title: Text("Localização", style: titleStyle),
              subtitle: Text("${apiaryData.cityId}, ${apiaryData.stateId}",
                  style: subtitleStyle),
            ),
            Divider(),
            ListTile(
              title: Text("Recursos Florais", style: titleStyle),
              subtitle: Text("${apiaryData.floralResources.join(', ')}",
                  style: subtitleStyle),
            ),
            Divider(),
            ListTile(
              title: Text("Quantidade de Colmeias", style: titleStyle),
              subtitle:
                  Text("${apiaryData.hives.length}", style: subtitleStyle),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                // Ação para editar detalhes do apiário
                Navigator.of(context)
                    .pushNamed(AppRoutes.APIARY_FORM, arguments: apiaryData);
              },
              child: Text('Editar Apiário'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para adicionar nova colmeia ou recurso
          // Navigator.of(context).pushNamed(AppRoutes.NEW_HIVE_FORM);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
