import 'package:app_bee/models/honeyBox.dart';
import 'package:app_bee/models/typeHive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/honeyBoxProvider.dart';
import 'package:app_bee/providers/typeHiveProvider.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HoneyBoxFormScreen extends StatefulWidget {
  const HoneyBoxFormScreen({Key? key}) : super(key: key);

  @override
  State<HoneyBoxFormScreen> createState() => _HoneyBoxFormState();
}

class _HoneyBoxFormState extends State<HoneyBoxFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  TypeHive? selectedTypeHive;
  bool isBusy = false;

  void _submitForm() {
    _formKey.currentState?.save();
    _formData['busy'] = isBusy;
    Provider.of<HoneyBoxProvider>(
      context,
      listen: false,
    ).addHoneyBoxFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Caixa'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: _submitForm,
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
              _buildSectionTitle('Informações da Caixa'),
              _buildTextFormField(
                label: 'TAG',
                onSaved: (value) => _formData['tag'] = value ?? '',
              ),
              _buildCheckbox(
                title: 'A caixa está ocupada?',
                value: isBusy,
                onChanged: (newValue) {
                  setState(() {
                    isBusy = newValue!;
                  });
                },
              ),
              _buildTextFormField(
                label: 'Número de Quadros',
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _formData['numberFrames'] = int.parse(value!),
              ),
              _buildTextFormField(
                label: 'Quadros em Uso',
                keyboardType: TextInputType.number,
                onSaved: (value) => _formData['busyFrames'] = int.parse(value!),
              ),
              _buildDropdown(),
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
    required void Function(String?) onSaved,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
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
        keyboardType: keyboardType,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildCheckbox({
    required String title,
    required bool value,
    required void Function(bool?) onChanged,
  }) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildDropdown() {
    return Consumer<TypeHiveProvider>(
      builder: (ctx, typeHiveProvider, _) {
        final allTypesHives = typeHiveProvider.typeHive;
        return DropdownSearch<TypeHive>(
          items: allTypesHives,
          itemAsString: (TypeHive u) => u.tipeHivesAsStringByName(),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Selecione o Modelo da caixa",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          onChanged: (TypeHive? selectedType) {
            selectedTypeHive = selectedType;
          },
          onSaved: (selectedType) =>
              _formData['typeHiveId'] = selectedType?.id ?? '',
        );
      },
    );
  }
}
