import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:app_bee/models/typeInspection.dart';
import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';
import 'package:intl/intl.dart'; // Importe para formatação de data

class InspectionSplitHiveFormScreen extends StatefulWidget {
  const InspectionSplitHiveFormScreen({Key? key}) : super(key: key);

  @override
  State<InspectionSplitHiveFormScreen> createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionSplitHiveFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  final TextEditingController _internalTempController = TextEditingController();
  final TextEditingController _externalTempController = TextEditingController();
  final TextEditingController _internalHumidityController =
      TextEditingController();
  final TextEditingController _externalHumidityController =
      TextEditingController();
  final TextEditingController _windSpeedController = TextEditingController();
  final TextEditingController _dateController =
      TextEditingController(); // Controller para o campo de data
  DateTime? _selectedDateTime; // Variável para armazenar a data selecionada

  @override
  void dispose() {
    _internalTempController.dispose();
    _externalTempController.dispose();
    _internalHumidityController.dispose();
    _externalHumidityController.dispose();
    _windSpeedController.dispose();
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
        title: Text('Tipos de Inspeção'),
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
        children: [
          _buildReportCard(
            context,
            'União de Colméias',
            Icons.add_circle,
            AppRoutes.PRODUCT_REPORT,
          ),
          _buildReportCard(
            context,
            'Divisão de Colmeias',
            Icons.remove_circle,
            AppRoutes.HEALTH_REPORT,
          ),
          _buildReportCard(
            context,
            'Rotina',
            Icons.search,
            AppRoutes.INSPECTION_REPORT,
          ),
          _buildReportCard(
            context,
            'Médicação',
            Icons.vaccines,
            AppRoutes.FLORAL_RESOURCES_REPORT,
          ),
          _buildReportCard(
            context,
            'Adição de Melgueira',
            Icons.money,
            AppRoutes.EXPENSE_REPORT,
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildReportCard(
      BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
