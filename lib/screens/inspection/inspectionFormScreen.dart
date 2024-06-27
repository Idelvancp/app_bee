import 'package:app_bee/models/typeInspection.dart';
import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';

class InspectionFormScreen extends StatefulWidget {
  const InspectionFormScreen({Key? key}) : super(key: key);

  @override
  State<InspectionFormScreen> createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  String? spawningQueen;

  void _toPagePopulationData(BuildContext context) {
    _formKey.currentState?.save();
    print("Estou no 1 indo para o 2 ${_formData}");
    Navigator.of(context).pushNamed(
      AppRoutes.INSPECTION_FORM2,
      arguments: _formData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final InspectionProvider inspections = Provider.of(context);
    final inspectionList = inspections.inspection; // Obter a lista de apiários
    final Map<String, dynamic> hiveId =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _formData['hiveId'] = hiveId['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Inspeção'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _toPagePopulationData,
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Consumer<TypeInspectionProvider>(
                  builder: (ctx, typeInspectionProvider, _) {
                    final TypeInspectionList =
                        typeInspectionProvider.typeInspection;
                    return DropdownSearch<TypeInspection>(
                      items: TypeInspectionList,
                      itemAsString: (TypeInspection u) => u.name,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Selecione um Tipo de Inspeção",
                        ),
                      ),
                      onSaved: (selectedTypeInspection) =>
                          _formData['typeInspectionId'] =
                              selectedTypeInspection?.name ?? '',
                    );
                  },
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: 'Temperatura Interna'),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) => _formData['internalTemperature'] =
                        double.tryParse(value ?? '') ?? 0.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Temperatura Externa'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _formData['externalTemperature'] =
                      double.tryParse(value ?? '') ?? 0.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Humidade Interna'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _formData['internalHumidity'] =
                      int.tryParse(value ?? '') ?? 0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Humidade Externa'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => _formData['externalHumidity'] =
                      int.tryParse(value ?? '') ?? 0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Velocidade do Vento'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) =>
                      _formData['windSpeed'] = int.tryParse(value ?? '') ?? 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _toPagePopulationData(context),
                      child: Text('Próximo'),
                    ),
                  ],
                ),
              ],
            )),
      ),
      drawer: AppDrawer(),
    );
  }
}
