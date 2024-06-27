import 'package:app_bee/providers/expenseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseFormScreen extends StatefulWidget {
  const ExpenseFormScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  void _submitForm() {
    _formKey.currentState?.save();
    Provider.of<ExpenseProvider>(
      context,
      listen: false,
    ).addExpenseFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Despesa'),
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
              _buildSectionTitle('Informações da Despesa'),
              _buildTextFormField(
                label: 'Custo',
                onSaved: (value) =>
                    _formData['cost'] = double.parse(value ?? '0'),
              ),
              _buildTextFormField(
                label: 'Data',
                onSaved: (value) => _formData['date'] = value ?? '',
              ),
              _buildTextFormField(
                label: 'Tipo de Despesa ID',
                onSaved: (value) =>
                    _formData['type_expense_id'] = int.parse(value ?? '0'),
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
        keyboardType: label == 'Custo'
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        onSaved: onSaved,
      ),
    );
  }
}
