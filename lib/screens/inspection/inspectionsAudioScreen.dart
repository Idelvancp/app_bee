import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/models/typeInspection.dart';
import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';
import 'package:intl/intl.dart'; // Importe para formatação de data
import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

class InspectionAudioScreen extends StatefulWidget {
  const InspectionAudioScreen({Key? key}) : super(key: key);

  @override
  State<InspectionAudioScreen> createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionAudioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  final TextEditingController _dateController =
      TextEditingController(); // Controller para o campo de data
  DateTime? _selectedDateTime; // Variável para armazenar a data selecionada

  @override
  void dispose() {
    _dateController.dispose(); // Dispose do controller de data
    super.dispose();
  }

  void _toPagePopulationData(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Navigator.of(context).pushNamed(
        AppRoutes.INSPECTION_FORM2,
        arguments: _formData,
      );
    }
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
          _dateController.text = dateFormat.format(_selectedDateTime!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inspeção Sonora'),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [],
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
