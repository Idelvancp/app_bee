import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/collectProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';
import 'package:intl/intl.dart'; // Importe para formatação de data

class CollectFormScreen extends StatefulWidget {
  const CollectFormScreen({Key? key}) : super(key: key);

  @override
  State<CollectFormScreen> createState() => _CollectFormState();
}

class _CollectFormState extends State<CollectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  final TextEditingController _dateController =
      TextEditingController(); // Controller para o campo de data
  DateTime? _selectedDateTime; // Variável para armazenar a data selecionada
  void _submitForm() {
    _formKey.currentState?.save();
    Provider.of<CollectProvider>(
      context,
      listen: false,
    ).addCollectFromData(_formData);
    Navigator.of(context).pushNamed('/hives-index');
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
        _selectedDateTime = pickedDate;
        DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        _dateController.text = dateFormat.format(pickedDate);
        _formData['date'] = pickedDate.toIso8601String();
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose(); // Dispose do controller de data
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> hive =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _formData['apiaryId'] = hive['apiary_id'];
    _formData['hiveId'] = hive['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Coleta'),
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
              _buildDateField(), // Adiciona o campo de data
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
        readOnly: true,
        onTap: _selectDate,
        onSaved: (value) => _formData['date'] = value ?? '',
      ),
    );
  }
}
