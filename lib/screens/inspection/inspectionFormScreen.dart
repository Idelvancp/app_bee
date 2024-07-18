import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:app_bee/models/typeInspection.dart';
import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';
import 'package:intl/intl.dart'; // Importe para formatação de data

class InspectionFormScreen extends StatefulWidget {
  const InspectionFormScreen({Key? key}) : super(key: key);

  @override
  State<InspectionFormScreen> createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  final TextEditingController _internalTempController = TextEditingController();
  final TextEditingController _externalTempController = TextEditingController();
  final TextEditingController _internalHumidityController =
      TextEditingController();
  final TextEditingController _externalHumidityController =
      TextEditingController();
  final TextEditingController _windSpeedController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(); // Controller para o campo de data
  DateTime? _selectedDateTime; // Variável para armazenar a data selecionada

  @override
  void dispose() {
    _internalTempController.dispose();
    _externalTempController.dispose();
    _internalHumidityController.dispose();
    _externalHumidityController.dispose();
    _windSpeedController.dispose();
    _dateController.dispose(); // Dispose do controller de data
    super.dispose();
  }

  void _toPagePopulationData(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Navigator.of(context).pushNamed(
        AppRoutes.INSPECTION_FORM2,
        arguments: _formData,
      );
    }
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
          _dateController.text = dateFormat.format(_selectedDateTime!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> hiveId =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _formData['hiveId'] = hiveId['id'];
    _formData['apiaryId'] = hiveId['apiary_id'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Inspeção'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _toPagePopulationData(context),
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
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
                  final typeInspectionList =
                      typeInspectionProvider.typeInspection;
                  return DropdownSearch<TypeInspection>(
                    items: typeInspectionList,
                    itemAsString: (TypeInspection u) => u.name,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Selecione um Tipo de Inspeção",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                    ),
                    onSaved: (selectedTypeInspection) =>
                        _formData['typeInspectionId'] =
                            selectedTypeInspection?.name ?? '',
                  );
                },
              ),
              _buildSectionTitle('Medições Climáticas'),
              _buildTextFormField(
                label: 'Temperatura Interna',
                controller: _internalTempController,
                onSaved: (value) => _formData['internalTemperature'] =
                    double.tryParse(value ?? '') ?? 0.0,
              ),
              _buildTextFormField(
                label: 'Temperatura Externa',
                controller: _externalTempController,
                onSaved: (value) => _formData['externalTemperature'] =
                    double.tryParse(value ?? '') ?? 0.0,
              ),
              _buildTextFormField(
                label: 'Humidade Interna',
                controller: _internalHumidityController,
                onSaved: (value) => _formData['internalHumidity'] =
                    int.tryParse(value ?? '') ?? 0,
              ),
              _buildTextFormField(
                label: 'Humidade Externa',
                controller: _externalHumidityController,
                onSaved: (value) => _formData['externalHumidity'] =
                    int.tryParse(value ?? '') ?? 0,
              ),
              _buildTextFormField(
                label: 'Velocidade do Vento',
                controller: _windSpeedController,
                onSaved: (value) =>
                    _formData['windSpeed'] = int.tryParse(value ?? '') ?? 0,
              ),
              _buildDateField(), // Adiciona o campo de data
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _toPagePopulationData(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Próximo'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    required void Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
        textInputAction: TextInputAction.next,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _dateController,
        decoration: InputDecoration(
          labelText: 'Data',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
        readOnly: true,
        onTap: _selectDate,
        onSaved: (value) => _formData['date'] = value ?? '',
      ),
    );
  }
}
