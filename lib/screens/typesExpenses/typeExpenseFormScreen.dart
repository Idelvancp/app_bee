import 'package:app_bee/providers/typeExpenseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeExpenseFormScreen extends StatefulWidget {
  const TypeExpenseFormScreen({Key? key}) : super(key: key);

  @override
  State<TypeExpenseFormScreen> createState() => _TypeExpenseFormState();
}

class _TypeExpenseFormState extends State<TypeExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  void _submitForm() {
    _formKey.currentState?.save();
    Provider.of<TypeExpenseProvider>(
      context,
      listen: false,
    ).addTypeExpenseFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Tipo de Despesa'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSectionTitle('Informações do Tipo de Despesa'),
              _buildTextFormField(
                label: 'Nome do Tipo de Despesa',
                onSaved: (value) => _formData['name'] = value ?? '',
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required void Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
        textInputAction: TextInputAction.next,
        onSaved: onSaved,
      ),
    );
  }
}
