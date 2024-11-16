import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/routes/appRoute.dart';
import '../../components/hiveItem.dart';
import 'package:app_bee/providers/hiveProvider.dart';
import 'package:app_bee/components/appDrawer.dart';
import 'package:app_bee/providers/inspectionProvider.dart';

class HivesScreen extends StatefulWidget {
  HivesScreen({Key? key}) : super(key: key);

  @override
  State<HivesScreen> createState() => HivesScreenState();
}

class HivesScreenState extends State<HivesScreen> {
  int? _selectedApiaryId;
  String? _selectedApiaryName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HiveProvider>(context, listen: false).loadHives();
      Provider.of<HiveProvider>(context, listen: false).loadIsnpectionsHives();
      // Aplicar filtro se initialApiaryId estiver presente

      final int initialApiaryId =
          ModalRoute.of(context)!.settings.arguments as int;

      if (initialApiaryId != null) {
        setState(() {
          _selectedApiaryId = initialApiaryId;
          _selectedApiaryName = _getApiaryNameById(_selectedApiaryId);
        });
      }
    });
  }

  List<Map<String, dynamic>> getUniqueApiaries(List<dynamic> hiveList) {
    Map<int, Map<String, dynamic>> apiaryMap = {};

    for (var hive in hiveList) {
      int apiaryId = hive['apiary_id'];
      String apiaryName = hive['apiary_name'];

      // Se o apiaryId não estiver no mapa, adicione-o
      if (!apiaryMap.containsKey(apiaryId)) {
        apiaryMap[apiaryId] = {
          'apiary_id': apiaryId,
          'apiary_name': apiaryName
        };
      }
    }

    // Retorne os valores únicos como uma lista
    return apiaryMap.values.toList();
  }

  String? _getApiaryNameById(int? apiaryId) {
    final HiveProvider hives = Provider.of(context, listen: false);
    final hivesList = hives.hivesScreen;
    final apiary = hivesList.firstWhere(
      (apiary) => apiary['apiary_id'] == apiaryId,
      orElse: () => null,
    );
    return apiary?['apiary_name'];
  }

  void _showFilterDialog(
      BuildContext context, List<Map<String, dynamic>> apiaryDropdownItems) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.purple.shade100,
            primaryColor: Colors.purple,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.purple,
              secondary: Colors.purpleAccent,
            ),
          ),
          child: AlertDialog(
            title: Text(
              "Selecione um Apiário",
              style: TextStyle(color: Colors.white),
            ),
            content: DropdownButton<int>(
              hint: Text("Selecione um Apiário"),
              value: _selectedApiaryId,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedApiaryId = newValue;
                  _selectedApiaryName = apiaryDropdownItems.firstWhere(
                      (apiary) =>
                          apiary['apiary_id'] == newValue)['apiary_name'];
                });
                Navigator.of(context).pop(); // Fechar o diálogo após a seleção
              },
              items: apiaryDropdownItems.map<DropdownMenuItem<int>>((apiary) {
                return DropdownMenuItem<int>(
                  value: apiary['apiary_id'],
                  child: Text(apiary['apiary_name']),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final HiveProvider hives = Provider.of(context);
    final hivesList = hives.hivesScreen;
    final hivesInspections = hives.inspectionsHives;

    // Filtrar a lista de colmeias com base no apiary_id selecionado
    final filteredHivesList = _selectedApiaryId == null
        ? hivesList
        : hivesList
            .where((api) => api['apiary_id'] == _selectedApiaryId)
            .toList();

    // Criar uma lista de itens para o dropdown com base nos apiários disponíveis, garantindo valores únicos
    final apiaryDropdownItems = getUniqueApiaries(hivesList);

    return Scaffold(
      appBar: AppBar(
        title: Text("Colmeias"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, apiaryDropdownItems),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_selectedApiaryName != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Apiário Selecionado: $_selectedApiaryName',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.all(25),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 5 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: filteredHivesList.map((api) {
                // Find matching inspections data for each hive
                var inspectionData = hivesInspections.firstWhere(
                  (insp) => insp['hive_id'] == api['id'],
                  orElse: () => <String,
                      dynamic>{}, // Return an empty map instead of null
                );

                return HiveItem(api, inspections: inspectionData);
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.HIVE_FORM);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
