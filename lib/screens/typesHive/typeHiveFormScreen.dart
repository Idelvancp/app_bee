import 'package:app_bee/providers/typeHiveProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeHiveFormScreen extends StatefulWidget {
  const TypeHiveFormScreen({Key? key}) : super(key: key);

  @override
  State<TypeHiveFormScreen> createState() => _TypeHiveFormState();
}

class _TypeHiveFormState extends State<TypeHiveFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  _submitForm() {
    _formKey.currentState?.save();
    Provider.of<TypeHiveProvider>(
      context,
      listen: false,
    ).addTypeHiveFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Tipo de Colmeia',
          style: TextStyle(fontSize: 20),
        ),
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
                        'Novo Tipo de Colmeia',
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
