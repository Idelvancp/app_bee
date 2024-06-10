import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/models/floralResources.dart';
import 'package:app_bee/data/cities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/dummy_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:math';

class ApiaryForm extends StatefulWidget {
  const ApiaryForm({Key? key}) : super(key: key);

//  final void Function(String, String, String, Biome, DateTime) onSubmit;

  //ApiaryForm(this.onSubmit);

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

  String estadoSelecionado = estados.first.toString();
  List<String> municipiosDoEstado = [];
  String municipioSelecionado = "Não selecionado";
  FloralResources? selectedResource;
  Biome selectedBiome = Biome.amazonia;

  _submitForm() {
    _formKey.currentState?.save();
    print(_formData.values);

    final newApiary = Apiary(
      id: "8",
      name: _formData['name'].toString(),
      state: _formData['state'].toString(),
      city: _formData['city'].toString(),
      // biome: _formData['biome'] as String,
      //date: DateTime.parse(_formData['date'] as String),
    );
    DUMMY_APIARIES.add(newApiary);
    print(DUMMY_APIARIES.last.city);
    print(newApiary.id);
    print(newApiary.name);
    print(newApiary.state);
    print(newApiary.city);
    // print(newApiary.biome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fomulário Apiário'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
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
                  decoration: InputDecoration(labelText: 'Nome'),
                  textInputAction: TextInputAction.next,
                  controller: _nameController,
                  onSaved: (name) => _formData['name'] = name ?? '',
                ),
                DropdownSearch<String>(
                  items: estados,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: "Selecione um Estado",
                      filled: true,
                    ),
                  ),
                  onChanged: (String? estado) {
                    setState(() {
                      estadoSelecionado = estado.toString();
                      municipiosDoEstado = municipios[estado]!;
                    });
                  },
                  selectedItem: estadoSelecionado,
                  onSaved: (state) => _formData['state'] = state ?? '',
                ),
                SizedBox(height: 10),
                DropdownSearch<String>(
                  items: municipiosDoEstado,
                  onChanged: print,
                  selectedItem: municipiosDoEstado.isNotEmpty
                      ? municipiosDoEstado[0]
                      : null,
                  enabled: estadoSelecionado != null,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: "Selecione um Município",
                      filled: true,
                    ),
                  ),
                  onSaved: (city) => _formData['city'] = city ?? '',
                ),
                /*
                TextFormField(
                  decoration: InputDecoration(labelText: 'Data de Instalação'),
                  textInputAction: TextInputAction.next,
                  controller: _dateController,
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                  onSaved: (date) => _formData['date'] = date ?? '',
                ),
               TextFormField(
              decoration: InputDecoration(labelText: 'Localização'),
              textInputAction: TextInputAction.next,
              controller: _locationController,
              readOnly: true,
              onTap: _getCurrentLocation,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, obtenha a localização.';
                }
                return null;
              },
            ),
                DropdownButtonFormField<Biome>(
                  decoration: InputDecoration(labelText: 'Bioma'),
                  items:
                      Biome.values.map<DropdownMenuItem<Biome>>((Biome biome) {
                    return DropdownMenuItem<Biome>(
                      value: biome,
                      child: Text(biome.name),
                    );
                  }).toList(),
                  onChanged: (Biome? newValue) {
                    setState(() {
                      selectedBiome = newValue!;
                    });
                  },
                  onSaved: (biome) => _formData['biome'] = selectedBiome.name,
                ),*/
                /*DropdownButtonFormField<FloralResources>(
                  decoration: InputDecoration(labelText: 'Recursos Florais'),
                  items: DUMMY_FLORAL_RESOURCES
                      .map<DropdownMenuItem<FloralResources>>(
                          (FloralResources resource) {
                    return DropdownMenuItem<FloralResources>(
                      value: resource,
                      child: Text(resource.name),
                    );
                  }).toList(),
                  onChanged: (FloralResources? newValue) {
                    setState(() {
                      selectedResource = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione um bioma.';
                    }
                    return null;
                  },
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text(
                        'Novo Apiário',
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

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        //DateTime pickedDate = _picked; // Supondo que _picked seja a sua data
        //DateFormat dateFormat = DateFormat('dd-MM-yyyy');
        //_dateController.text = _picked.toString();
        //_dateController.text = dateFormat.format(pickedDate);
        DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        _dateController.text = dateFormat.format(_picked);
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Testa se o serviço de localização está habilitado.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationController.text = "Serviço de localização desativado.";
      });
      return;
    }

    // Verifica se temos permissão de localização.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationController.text = "Permissão de localização negada.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationController.text =
            "Permissão de localização negada permanentemente.";
      });
      return;
    }

    // Obtém a localização atual.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _locationController.text =
          "Lat: ${position.latitude}, Long: ${position.longitude}";
    });
  }
}
