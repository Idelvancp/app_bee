import 'package:app_bee/models/apiary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/dummy_data.dart';

class ApiaryForm extends StatefulWidget {
  final void Function(String, int, Biome) onSubmit;

  ApiaryForm(this.onSubmit);

  @override
  State<ApiaryForm> createState() => _ApiaryFormState();
}

class _ApiaryFormState extends State<ApiaryForm> {
  final nameController = TextEditingController();

  final cityController = TextEditingController();

  final biomeController = TextEditingController();

  _submitForm() {
    final name = nameController.text;
    final cityId = double.tryParse(valueController.text) ?? 0.0;
    final biome = DateTime.parse(_dateController.text);
    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, date);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _dropdownItems = ['Item 1', 'Item 2', 'Item 3'];
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Item',
                border: OutlineInputBorder(),
              ),
              value: value,
              items: _dropdownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select an item' : null,
            ),
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Nome do Apiário',
              ),
            ),
            TextField(
              controller: valueController,
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                filled: true,
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              readOnly: true,
              onTap: () {
                _selectDate();
              },
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
                    'Nova Transação',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                  onPressed: _submitForm,
                )
              ],
            ),
          ],
        ),
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
}
