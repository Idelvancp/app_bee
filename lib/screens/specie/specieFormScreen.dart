import 'package:app_bee/providers/specieProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/models/specie.dart';

class SpecieFormScreen extends StatefulWidget {
  const SpecieFormScreen({Key? key}) : super(key: key);

  @override
  State<SpecieFormScreen> createState() => _SpecieFormState();
}

class _SpecieFormState extends State<SpecieFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  bool _isEditing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Specie? specie =
        ModalRoute.of(context)?.settings.arguments as Specie?;
    if (specie != null && !_isEditing) {
      _formData['id'] = specie.id!;
      _formData['name'] = specie.name;
      _isEditing = true;
    }
  }

  void _submitForm() {
    _formKey.currentState?.save();
    final specieProvider = Provider.of<SpecieProvider>(
      context,
      listen: false,
    );
    if (_isEditing) {
      final updatedSpecie = Specie(
        id: _formData['id'] as int,
        name: _formData['name'] as String,
        createdAt: DateTime.now(), // Você pode ajustar isso conforme necessário
        updatedAt: DateTime.now(),
      );
      specieProvider.updateSpecie(updatedSpecie);
    } else {
      specieProvider.addSpecieFromData(_formData);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Espécie' : 'Cadastrar Espécie'),
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
              _buildSectionTitle('Informações da Espécie'),
              _buildTextFormField(
                label: 'Nome',
                initialValue: _formData['name'] as String?,
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
    String? initialValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        initialValue: initialValue,
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
