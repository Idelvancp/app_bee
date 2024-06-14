import 'package:app_bee/providers/floralResourceProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloralResourceFormScreen extends StatefulWidget {
  const FloralResourceFormScreen({Key? key}) : super(key: key);

  @override
  State<FloralResourceFormScreen> createState() => _FloralResourceFormState();
}

class _FloralResourceFormState extends State<FloralResourceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  _submitForm() {
    _formKey.currentState?.save();
    Provider.of<FloralResourceProvider>(
      context,
      listen: false,
    ).addFloralResourceFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Recurso Floral'),
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
                        'Novo Recurso Floral',
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
