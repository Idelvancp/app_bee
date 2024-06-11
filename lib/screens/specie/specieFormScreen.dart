import 'package:app_bee/providers/specieProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecieFormScreen extends StatefulWidget {
  const SpecieFormScreen({Key? key}) : super(key: key);

  @override
  State<SpecieFormScreen> createState() => _SpecieFormState();
}

class _SpecieFormState extends State<SpecieFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  _submitForm() {
    _formKey.currentState?.save();
    Provider.of<SpecieProvider>(
      context,
      listen: false,
    ).addSpecieFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fomulário Spécie'),
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
                  onSaved: (name) => _formData['name'] = name ?? '',
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
                        'Nova Espécie',
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
