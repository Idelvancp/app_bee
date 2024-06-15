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

  _submitForm() {
    _formKey.currentState?.save();
    _formData['busy'] = isBusy;
    print(_formData.entries);
    Provider.of<HoneyBoxProvider>(
      context,
      listen: false,
    ).addHoneyBoxFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final HoneyBoxProvider honeyBoxes = Provider.of(context);
    final honeyBoxesList = honeyBoxes.honeyBoxe;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Caixa',
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'TAG'),
                  textInputAction: TextInputAction.next,
                  onSaved: (tag) => _formData['tag'] = tag ?? '',
                ),
                CheckboxListTile(
                  title: Text("A caixa está ocupada ?"),
                  value: isBusy,
                  onChanged: (newValue) {
                    setState(() {
                      isBusy = newValue!;
                      print("000000000000000000000000000000");
                      print(isBusy);
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Número de Quadros'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (numberFrames) =>
                      _formData['numberFrames'] = int.parse(numberFrames!),
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
