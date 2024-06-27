import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';

class InspectionForm2Screen extends StatefulWidget {
  const InspectionForm2Screen({Key? key}) : super(key: key);

  @override
  State<InspectionForm2Screen> createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionForm2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};

  String? ageQueen;
  String? numberBees;
  String? spawningQueen;
  String? larvaePresenceDistribution;
  String? larvaeHealthDevelopment;
  String? pupaPresenceDistribution;
  String? pupaHealthDevelopment;

  String?
      eggLayingStatus; // Nova variável para armazenar a seleção de postura de ovos
  String?
      pupaeState; // Nova variável para armazenar a seleção do estado das pupas
  String?
      healthStatus; // Nova variável para armazenar a seleção de saúde e desenvolvimento

  void _toPageProductsData(BuildContext context) {
    _formKey.currentState?.save();
    _formData['spawningQueen'] = spawningQueen ?? '';
    _formData['larvaePresenceDistribution'] = larvaePresenceDistribution ?? '';
    _formData['larvaeHealthDevelopment'] = larvaeHealthDevelopment ?? '';
    _formData['pupaPresenceDistribution'] = pupaPresenceDistribution ?? '';
    _formData['pupaHealthDevelopment'] = pupaHealthDevelopment ?? '';

    print("**********************${_formData}");
    print("Coleta");
    Navigator.of(context).pushNamed(
      AppRoutes.INSPECTION_FORM3,
      arguments: _formData,
    );
    /*else {
      Provider.of<InspectionProvider>(
        context,
        listen: false,
      ).addInspectionFromData(_formData);
      Navigator.of(context).pop();
    }*/
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
            onPressed: () => _toPageProductsData(context),
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
                  initialValue:
                      numberBees, // Use initialValue to set the initial value of the field
                  decoration:
                      InputDecoration(labelText: 'Tamanho da População'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    numberBees = value; // Update the state variable
                    _formData['numberBees'] = int.tryParse(value ?? '') ??
                        0; // Save the value in the form data
                  },
                ),
                Text('Estado da Rainha',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextFormField(
                  initialValue:
                      ageQueen, // Use initialValue to set the initial value of the field
                  decoration: InputDecoration(labelText: 'Idade da Rainha'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    ageQueen = value; // Update the state variable
                    _formData['ageQueen'] = double.tryParse(value ?? '') ??
                        0.0; // Save the value in the form data
                  },
                ),
                Text('Postura dos Ovos',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                RadioListTile<String>(
                  title: Text('Uniforme'),
                  value: 'Uniforme',
                  groupValue: spawningQueen,
                  onChanged: (String? value) {
                    setState(() {
                      spawningQueen = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Irregular'),
                  value: 'Irregular',
                  groupValue: spawningQueen,
                  onChanged: (String? value) {
                    setState(() {
                      spawningQueen = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Ausente'),
                  value: 'Ausente',
                  groupValue: spawningQueen,
                  onChanged: (String? value) {
                    setState(() {
                      spawningQueen = value;
                    });
                  },
                ),
                Text('Larvas Presença e Distribuição',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                RadioListTile<String>(
                  title: Text('Uniforme'),
                  value: 'Uniforme',
                  groupValue: larvaePresenceDistribution,
                  onChanged: (String? value) {
                    setState(() {
                      larvaePresenceDistribution = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Irregular'),
                  value: 'Irregular',
                  groupValue: larvaePresenceDistribution,
                  onChanged: (String? value) {
                    setState(() {
                      larvaePresenceDistribution = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Ausente'),
                  value: 'Ausente',
                  groupValue: larvaePresenceDistribution,
                  onChanged: (String? value) {
                    setState(() {
                      larvaePresenceDistribution = value;
                    });
                  },
                ),
                SizedBox(height: 5),
                Text('Larvas Saúde e Desenvolvimento',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                RadioListTile<String>(
                  title: Text('Saudável'),
                  value: 'Saudável',
                  groupValue: larvaeHealthDevelopment,
                  onChanged: (String? value) {
                    setState(() {
                      larvaeHealthDevelopment = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Doente'),
                  value: 'Doente',
                  groupValue: larvaeHealthDevelopment,
                  onChanged: (String? value) {
                    setState(() {
                      larvaeHealthDevelopment = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Mortas'),
                  value: 'Mortas',
                  groupValue: larvaeHealthDevelopment,
                  onChanged: (String? value) {
                    setState(() {
                      larvaeHealthDevelopment = value;
                    });
                  },
                ),
                Text('Pupas Presença e Distribuição',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                RadioListTile<String>(
                  title: Text('Uniforme'),
                  value: 'Uniforme',
                  groupValue: pupaPresenceDistribution,
                  onChanged: (String? value) {
                    setState(() {
                      pupaPresenceDistribution = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Irregular'),
                  value: 'Irregular',
                  groupValue: pupaPresenceDistribution,
                  onChanged: (String? value) {
                    setState(() {
                      pupaPresenceDistribution = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Ausente'),
                  value: 'Ausente',
                  groupValue: pupaPresenceDistribution,
                  onChanged: (String? value) {
                    setState(() {
                      pupaPresenceDistribution = value;
                    });
                  },
                ),
                SizedBox(height: 5),
                Text('Pupas Saúde e Desenvolvimento',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                RadioListTile<String>(
                  title: Text('Saudável'),
                  value: 'Saudável',
                  groupValue: pupaHealthDevelopment,
                  onChanged: (String? value) {
                    setState(() {
                      pupaHealthDevelopment = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Doente'),
                  value: 'Doente',
                  groupValue: pupaHealthDevelopment,
                  onChanged: (String? value) {
                    setState(() {
                      pupaHealthDevelopment = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Mortas'),
                  value: 'Mortas',
                  groupValue: pupaHealthDevelopment,
                  onChanged: (String? value) {
                    setState(() {
                      pupaHealthDevelopment = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _toPageProductsData(context),
                      child: Text('Próximo'),
                    ),
                  ],
                ),
              ],
            )),
      ),
      drawer: AppDrawer(),
    );
  }
}
