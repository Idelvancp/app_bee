import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeInspectionFormScreen extends StatefulWidget {
  const TypeInspectionFormScreen({Key? key}) : super(key: key);

  @override
  State<TypeInspectionFormScreen> createState() => _TypeInspectionFormState();
}

class _TypeInspectionFormState extends State<TypeInspectionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  _submitForm() {
    _formKey.currentState?.save();
    Provider.of<TypeInspectionProvider>(
      context,
      listen: false,
    ).addTypeInspectionFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Tipo de Inspeção'),
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
                        'Novo Tipo de Inspeção',
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
