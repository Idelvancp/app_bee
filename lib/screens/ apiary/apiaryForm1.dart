import 'package:app_bee/models/apiary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/dummy_data.dart';
import 'package:geolocator/geolocator.dart';
import 'apiaryForm2.dart';

class ApiaryForm1 extends StatefulWidget {
  @override
  State<ApiaryForm1> createState() => _ApiaryForm1State();
}

class _ApiaryForm1State extends State<ApiaryForm1> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fomulário Apiário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome'),
              textInputAction: TextInputAction.next,
              controller: _nameController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Data de Instalação'),
              textInputAction: TextInputAction.next,
              controller: _dateController,
              readOnly: true,
              onTap: () {
                _selectDate();
              },
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApiaryForm2(
                        name: _nameController.text,
                        date: _dateController.text,
                        location: _locationController.text,
                      ),
                    ),
                  );
                }
              },
              child: Text('Próximo'),
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
