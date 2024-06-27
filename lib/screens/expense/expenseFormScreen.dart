import 'package:app_bee/models/apiary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:app_bee/models/typeExpense.dart';
import 'package:app_bee/providers/apiaryProvider.dart';
import 'package:app_bee/providers/expenseProvider.dart';
import 'package:app_bee/providers/typeExpenseProvider.dart';

class ExpenseFormScreen extends StatefulWidget {
  const ExpenseFormScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  final _dateController = TextEditingController();
  TypeExpense? selectedTypeExpense;
  Apiary? selectedApiary;
  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDateTime = pickedDate; // Atualizar apenas com a data
        DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        _dateController.text = dateFormat.format(pickedDate);
        _formData['date'] = pickedDate.toIso8601String();
      });
    }
  }

  void _submitForm() {
    _formKey.currentState?.save();
    print(_formData.entries);
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
              _buildDateDropdown(),
              _buildApiaryDropdown(),
              _buildTextFormField(
                label: 'Custo',
                onSaved: (value) =>
                    _formData['cost'] = double.parse(value ?? '0'),
              ),
              _buildDateField(),
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

  Widget _buildDateDropdown() {
    return Consumer<TypeExpenseProvider>(
      builder: (ctx, typesExpensesProvider, _) {
        final allTypesExpenses = typesExpensesProvider.typeExpenses;
        return DropdownSearch<TypeExpense>(
          items: allTypesExpenses,
          itemAsString: (TypeExpense u) => u.name,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Selecione o Tipo de Despesa",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          onChanged: (TypeExpense? selectedType) {
            selectedTypeExpense = selectedType;
          },
          onSaved: (selectedType) =>
              _formData['type_expense_id'] = selectedType?.id ?? '',
        );
      },
    );
  }

  Widget _buildApiaryDropdown() {
    return Consumer<ApiaryProvider>(
      builder: (ctx, apiaryProvider, _) {
        final allApiaries = apiaryProvider.apiary;
        return DropdownSearch<Apiary>(
          items: allApiaries,
          itemAsString: (Apiary u) => u.name,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Selecione o Apiário",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
          onChanged: (Apiary? selectedType) {
            selectedApiary = selectedType;
          },
          onSaved: (selectedType) =>
              _formData['apiary_id'] = selectedType?.id ?? '',
        );
      },
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

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _dateController,
        decoration: InputDecoration(
          labelText: 'Data',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple),
          ),
        ),
        readOnly: true, // Campo de texto apenas leitura
        onTap: _selectDate,
        onSaved: (value) => _formData['date'] = value ?? '',
      ),
    );
  }
}
