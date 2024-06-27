import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/models/honeyBox.dart';
import 'package:app_bee/models/specie.dart';
import 'package:app_bee/models/typeHive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/hiveProvider.dart';
import 'package:app_bee/providers/typeHiveProvider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:app_bee/providers/honeyBoxProvider.dart';
import 'package:app_bee/providers/specieProvider.dart';
import 'package:app_bee/models/apiaryList.dart';

class HiveFormScreen extends StatefulWidget {
  const HiveFormScreen({Key? key}) : super(key: key);

  @override
  State<HiveFormScreen> createState() => _HiveFormState();
}

class _HiveFormState extends State<HiveFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  TypeHive? selectedTypeHive;
  HoneyBox? selectedHoneyBox;
  Specie? selectedSpecie;

  void _submitForm() {
    _formKey.currentState?.save();
    Provider.of<HiveProvider>(
      context,
      listen: false,
    ).addHiveFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Colmeia'),
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
              _buildSectionTitle('Informações da Colmeia'),
              _buildDropdownHoneyBox(),
              _buildDropdownSpecie(),
              _buildDropdownApiary(),
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

  Widget _buildDropdownHoneyBox() {
    return Consumer<HoneyBoxProvider>(
      builder: (ctx, honeyBoxProvider, _) {
        final honeyBoxList = honeyBoxProvider.honeyBoxe;
        return DropdownSearch<HoneyBox>(
          items: honeyBoxList,
          itemAsString: (HoneyBox u) => u.tag,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Selecione uma Caixa",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          onChanged: (HoneyBox? selectedBox) {
            selectedHoneyBox = selectedBox;
          },
          onSaved: (selectedHoneyBox) =>
              _formData['honeyBoxId'] = selectedHoneyBox?.id ?? '',
        );
      },
    );
  }

  Widget _buildDropdownSpecie() {
    return Consumer<SpecieProvider>(
      builder: (ctx, specieProvider, _) {
        final allSpecies = specieProvider.specie;
        return DropdownSearch<Specie>(
          items: allSpecies,
          itemAsString: (Specie u) => u.name,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Selecione uma Espécie",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          onChanged: (Specie? selectedSpec) {
            selectedSpecie = selectedSpec;
          },
          onSaved: (selectedSpecie) =>
              _formData['specieId'] = selectedSpecie?.id ?? '',
        );
      },
    );
  }

  Widget _buildDropdownApiary() {
    return Consumer<ApiaryList>(
      builder: (ctx, apiaryList, _) {
        final allApiaries = apiaryList.apiary;
        return DropdownSearch<Apiary>(
          items: allApiaries,
          itemAsString: (Apiary u) => u.name,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Selecione um Apiário",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          onChanged: (Apiary? selectedApiary) {
            _formData['apiaryId'] = selectedApiary?.id ?? '';
          },
          onSaved: (selectedApiary) =>
              _formData['apiaryId'] = selectedApiary?.id ?? '',
        );
      },
    );
  }
}
