import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';

class InspectionForm3Screen extends StatefulWidget {
  const InspectionForm3Screen({Key? key}) : super(key: key);

  @override
  State<InspectionForm3Screen> createState() => _InspectionForm3State();
}

class _InspectionForm3State extends State<InspectionForm3Screen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  double? amountHoney;
  double? amountWax;
  double? amountPropolis;
  double? amountRoyalJelly;

  void _submitForm() {
    _formKey.currentState?.save();
    print("Form Data: $_formData");
    Provider.of<InspectionProvider>(
      context,
      listen: false,
    ).addInspectionFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> populationEnvironment =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _formData.addAll(populationEnvironment);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Inspeção'),
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade de Mel',
                  labelStyle: TextStyle(color: Colors.purple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _formData['amountHoney'] =
                    double.tryParse(value ?? '') ?? 0.0,
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade de Cera',
                  labelStyle: TextStyle(color: Colors.purple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _formData['amountWax'] =
                    double.tryParse(value ?? '') ?? 0.0,
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade de Própolis',
                  labelStyle: TextStyle(color: Colors.purple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _formData['amountPropolis'] =
                    double.tryParse(value ?? '') ?? 0.0,
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade de Geléia Real',
                  labelStyle: TextStyle(color: Colors.purple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onSaved: (value) => _formData['amountRoyalJelly'] =
                    double.tryParse(value ?? '') ?? 0.0,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Salvar'),
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
}
