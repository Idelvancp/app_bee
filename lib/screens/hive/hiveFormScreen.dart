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
    Provider.of<HiveProvider>(
      context,
      listen: false,
    ).addHiveFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final HiveProvider hives = Provider.of(context);
    final hivesList = hives.hive;

    final HoneyBoxProvider honeyBoxes = Provider.of(context);
    final HoneyBoxList = honeyBoxes.honeyBoxe;
    final SpecieProvider species = Provider.of(context);
    final speciesList = species.specie;
    print("Estou aqui");
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
                    final allHoneyBox = honeyBoxProvider.honeyBoxe;
                    return DropdownSearch<HoneyBox>(
                      items: allHoneyBox,
                      itemAsString: (HoneyBox u) => u.tag,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Selecione uma Caixa",
                        ),
                      ),
                      onSaved: (selectedHoneyBox) => _formData['honey_box_id'] =
                          selectedHoneyBox?.id ?? '',
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
                          _formData['specie_id'] = selectedSpecie?.id ?? '',
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Quadros em Uso'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (busyFrames) =>
                      _formData['busyFrames'] = int.parse(busyFrames!),
                ),
                Consumer<TypeHiveProvider>(
                  builder: (ctx, typeHiveProvider, _) {
                    final allTypesHives = typeHiveProvider.typeHive;
                    return DropdownSearch<TypeHive>(
                      items: allTypesHives,
                      itemAsString: (TypeHive u) => u.tipeHivesAsStringByName(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Selecione o Modelo da caixa",
                        ),
                      ),
                      onChanged: (TypeHive? selectedType) {
                        selectedTypeHive = selectedType;
                      },
                      onSaved: (selectedType) =>
                          _formData['typeHiveId'] = selectedType?.id ?? '',
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
