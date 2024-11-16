import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:app_bee/components/appDrawer.dart';

class InspectionForm2Screen extends StatefulWidget {
  const InspectionForm2Screen({Key? key}) : super(key: key);

  @override
  State<InspectionForm2Screen> createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionForm2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};

  final TextEditingController _numberBeesController = TextEditingController();
  final TextEditingController _ageQueenController = TextEditingController();

  String? sizePopulation;
  String? spawningQueen;
  String? larvaePresenceDistribution;
  String? larvaeHealthDevelopment;
  String? pupaPresenceDistribution;
  String? pupaHealthDevelopment;

  @override
  void initState() {
    super.initState();
    _numberBeesController.text = '';
    _ageQueenController.text = '';
  }

  @override
  void dispose() {
    _numberBeesController.dispose();
    _ageQueenController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    _formKey.currentState?.save();
    _formData['numberBees'] = int.tryParse(_numberBeesController.text) ?? 0;
    _formData['ageQueen'] = double.tryParse(_ageQueenController.text) ?? 0.0;
    _formData['spawningQueen'] = spawningQueen ?? '';
    _formData['larvaePresenceDistribution'] = larvaePresenceDistribution ?? '';
    _formData['larvaeHealthDevelopment'] = larvaeHealthDevelopment ?? '';
    _formData['pupaPresenceDistribution'] = pupaPresenceDistribution ?? '';
    _formData['pupaHealthDevelopment'] = pupaHealthDevelopment ?? '';

    Provider.of<InspectionProvider>(
      context,
      listen: false,
    ).addInspectionFromData(_formData);
    Navigator.of(context).pushNamed('/hives-index');
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> environmentData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _formData.addAll(environmentData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Inspeção'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _submitForm(context),
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
              _buildSectionTitle('Tamanho da População (Score)'),
              _buildRadioGroup(
                options: ['Alto', 'Médio', 'Baixo'],
                groupValue: sizePopulation,
                onChanged: (value) => setState(() => sizePopulation = value),
              ),
              _buildSectionTitle('Estado da Rainha'),
              _buildTextFormField(
                label: 'Idade da Rainha (Meses)',
                controller: _ageQueenController,
                onSaved: (value) {
                  _formData['ageQueen'] = double.tryParse(value ?? '') ?? 0.0;
                },
              ),
              _buildSectionTitle('Postura dos Ovos'),
              _buildRadioGroup(
                options: ['Uniforme', 'Irregular', 'Ausente'],
                groupValue: spawningQueen,
                onChanged: (value) => setState(() => spawningQueen = value),
              ),
              _buildSectionTitle('Larvas Presença e Distribuição'),
              _buildRadioGroup(
                options: ['Uniforme', 'Irregular', 'Ausente'],
                groupValue: larvaePresenceDistribution,
                onChanged: (value) =>
                    setState(() => larvaePresenceDistribution = value),
              ),
              _buildSectionTitle('Larvas Saúde e Desenvolvimento'),
              _buildRadioGroup(
                options: ['Saudável', 'Doente', 'Mortas'],
                groupValue: larvaeHealthDevelopment,
                onChanged: (value) =>
                    setState(() => larvaeHealthDevelopment = value),
              ),
              _buildSectionTitle('Pupas Presença e Distribuição'),
              _buildRadioGroup(
                options: ['Uniforme', 'Irregular', 'Ausente'],
                groupValue: pupaPresenceDistribution,
                onChanged: (value) =>
                    setState(() => pupaPresenceDistribution = value),
              ),
              _buildSectionTitle('Pupas Saúde e Desenvolvimento'),
              _buildRadioGroup(
                options: ['Saudável', 'Doente', 'Mortas'],
                groupValue: pupaHealthDevelopment,
                onChanged: (value) =>
                    setState(() => pupaHealthDevelopment = value),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _submitForm(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Próximo'),
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
    required TextEditingController controller,
    required void Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
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

  Widget _buildRadioGroup({
    required List<String> options,
    required String? groupValue,
    required void Function(String?) onChanged,
  }) {
    return Column(
      children: options
          .map(
            (option) => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: Colors.purple,
            ),
          )
          .toList(),
    );
  }
}
