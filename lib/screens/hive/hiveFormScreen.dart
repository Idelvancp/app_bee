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

  _submitForm() {
    _formKey.currentState?.save();
    print(_formData.entries);
    Provider.of<HiveProvider>(
      context,
      listen: false,
    ).addHiveFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final HiveProvider hives = Provider.of(context);
    final HoneyBoxProvider honeyBoxes = Provider.of(context);
    final SpecieProvider species = Provider.of(context);
    final ApiaryList apiaries = Provider.of(context);
    final apiaryList = apiaries.apiary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Colmeia',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _submitForm,
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
                Consumer<HoneyBoxProvider>(
                  builder: (ctx, honeyBoxProvider, _) {
                    final HoneyBoxList = honeyBoxProvider.honeyBoxe;
                    return DropdownSearch<HoneyBox>(
                      items: HoneyBoxList,
                      itemAsString: (HoneyBox u) => u.tag,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Selecione uma Caixa",
                        ),
                      ),
                      onSaved: (selectedHoneyBox) =>
                          _formData['honeyBoxId'] = selectedHoneyBox?.id ?? '',
                    );
                  },
                ),
                Consumer<SpecieProvider>(
                  builder: (ctx, specieProvider, _) {
                    final allSpecies = specieProvider.specie;
                    return DropdownSearch<Specie>(
                      items: allSpecies,
                      itemAsString: (Specie u) => u.name,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Selecione o uma Espécie",
                        ),
                      ),
                      onChanged: (Specie? select) {
                        selectedSpecie = select;
                        print(selectedSpecie?.name);
                      },
                      onSaved: (selectedSpecie) =>
                          _formData['specieId'] = selectedSpecie?.id ?? '',
                    );
                  },
                ),
                Consumer<ApiaryList>(
                  builder: (ctx, apiaryList, _) {
                    final allApiaries = apiaryList.apiary;
                    return DropdownSearch<Apiary>(
                      items: allApiaries,
                      itemAsString: (Apiary u) => u.name,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Selecione um Apiário",
                        ),
                      ),
                      onChanged: print,
                      onSaved: (apiarySelected) =>
                          _formData['apiaryId'] = apiarySelected?.id ?? '',
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text(
                        'Nova Caixa',
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                      onPressed: _submitForm,
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
