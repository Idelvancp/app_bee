import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/providers/apiaryProvider.dart';
import 'package:app_bee/models/floralResource.dart';
import 'package:app_bee/providers/floralResourceProvider.dart';
import 'package:app_bee/data/cities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ApiaryForm extends StatefulWidget {
  const ApiaryForm({Key? key}) : super(key: key);

  @override
  State<ApiaryForm> createState() => _ApiaryFormState();
}

class _ApiaryFormState extends State<ApiaryForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  List dropdownBiome = Biome.values.toList();

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();

  Map<String, dynamic> estadoSelecionado = estados.first;
  List<Map<String, dynamic>> municipiosDoEstado = [];
  Map<String, dynamic>? municipioSelecionado;
  List<FloralResource> selectedResource = [];

  DateTime? _selectedDateTime;
  Biome selectedBiome = Biome.amazonia;

  @override
  void initState() {
    super.initState();
    Provider.of<FloralResourceProvider>(context, listen: false)
        .loadFloralResources();
  }

  void _submitForm() {
    _formKey.currentState?.save();
    _formData['fResources'] = selectedResource;
    Provider.of<ApiaryProvider>(context, listen: false)
        .addApiaryFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Apiário'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save, color: Colors.white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSectionTitle('Informações Gerais'),
              _buildTextFormField(
                label: 'Nome',
                controller: _nameController,
                onSaved: (value) => _formData['name'] = value ?? '',
              ),
              _buildSectionTitle('Recursos Florais'),
              _buildFloralResourcesDropdown(),
              _buildSectionTitle('Localização'),
              _buildStateDropdown(),
              SizedBox(height: 10),
              _buildCityDropdown(),
              _buildTextFormField(
                label: 'Data de Instalação',
                controller: _dateController,
                readOnly: true,
                onTap: _selectDate,
                onSaved: (value) =>
                    _formData['date'] = _selectedDateTime ?? DateTime.now(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
    bool readOnly = false,
    VoidCallback? onTap,
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
        readOnly: readOnly,
        onTap: onTap,
      ),
    );
  }

  Widget _buildFloralResourcesDropdown() {
    return Consumer<FloralResourceProvider>(
      builder: (ctx, floralResourceProvider, _) {
        final allFloralResources = floralResourceProvider.floralResource;
        return DropdownSearch<FloralResource>.multiSelection(
          items: allFloralResources,
          itemAsString: (FloralResource u) => u.floralResourceAsStringByName(),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Selecione Recursos Florais",
              filled: true,
            ),
          ),
          onChanged: (List<FloralResource> selectedRe) {
            selectedResource = selectedRe;
          },
        );
      },
    );
  }

  Widget _buildStateDropdown() {
    return DropdownSearch<Map<String, dynamic>>(
      items: estados,
      itemAsString: (Map<String, dynamic> estado) => estado['nome'] ?? '',
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: "Selecione um Estado",
          filled: true,
        ),
      ),
      selectedItem: estadoSelecionado,
      onChanged: (Map<String, dynamic>? estado) {
        setState(() {
          estadoSelecionado = estado!;
          municipiosDoEstado =
              municipios[estado['id'] as int] as List<Map<String, dynamic>>;
        });
      },
      onSaved: (state) => _formData['stateId'] = state?['id'] as int,
    );
  }

  Widget _buildCityDropdown() {
    return DropdownSearch<Map<String, dynamic>>(
      items: municipiosDoEstado,
      itemAsString: (Map<String, dynamic> municipio) => municipio['nome'] ?? '',
      onChanged: (Map<String, dynamic>? municipio) {
        setState(() {
          municipioSelecionado = municipio!;
        });
      },
      enabled: estadoSelecionado != null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: "Selecione um Município",
          filled: true,
        ),
      ),
      onSaved: (city) => _formData['cityId'] = city?['id'] as int,
    );
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
          DateFormat dateFormat = DateFormat('yyyy-MM-dd');
          _dateController.text = dateFormat.format(pickedDate);
        });
      }
    }
  }
}
