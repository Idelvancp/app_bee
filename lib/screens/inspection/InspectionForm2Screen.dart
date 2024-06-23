import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InspectionForm2Screen extends StatefulWidget {
  const InspectionForm2Screen({Key? key}) : super(key: key);

  @override
  State<InspectionForm2Screen> createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionForm2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  String? ageQueen;
  String? spawningQueen;
  String? larvae;
  String? pupa;

  String?
      eggLayingStatus; // Nova variável para armazenar a seleção de postura de ovos
  String?
      pupaeState; // Nova variável para armazenar a seleção do estado das pupas
  String?
      healthStatus; // Nova variável para armazenar a seleção de saúde e desenvolvimento

  _submitForm() {
    _formKey.currentState?.save();
    _formData['spawningQueen'] = spawningQueen ?? '';
    _formData['larvae'] = larvae ?? '';
    _formData['pupa'] = pupa ?? '';

    print("**********************${_formData}");
    /*Provider.of<InspectionProvider>(
      context,
      listen: false,
    ).addInspectionFromData(_formData);
    Navigator.of(context).pop(); */
  }

  _toPagePopulationData() {
    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> environmentData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    print("GGGGGGGGGGGGGGGGGGGGGGGGGG${environmentData}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Inspeção'),
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
                  decoration:
                      InputDecoration(labelText: 'Tamanho da População'),
                  textInputAction: TextInputAction.next,
                  onSaved: (numberBees) =>
                      _formData['numberBees'] = numberBees ?? '',
                ),
                Text('Estado da Rainha',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Idade da Rainha'),
                  textInputAction: TextInputAction.next,
                  onSaved: (ageQueen) => _formData['ageQueen'] = ageQueen ?? '',
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
                  groupValue: larvae,
                  onChanged: (String? value) {
                    setState(() {
                      larvae = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Irregular'),
                  value: 'Irregular',
                  groupValue: larvae,
                  onChanged: (String? value) {
                    setState(() {
                      larvae = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Ausente'),
                  value: 'Ausente',
                  groupValue: larvae,
                  onChanged: (String? value) {
                    setState(() {
                      larvae = value;
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
                  groupValue: healthStatus,
                  onChanged: (String? value) {
                    setState(() {
                      healthStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Doente'),
                  value: 'Doente',
                  groupValue: healthStatus,
                  onChanged: (String? value) {
                    setState(() {
                      healthStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Mortas'),
                  value: 'Mortas',
                  groupValue: healthStatus,
                  onChanged: (String? value) {
                    setState(() {
                      healthStatus = value;
                    });
                  },
                ),
                Text('Pupas Presença e Distribuição',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                RadioListTile<String>(
                  title: Text('Uniforme'),
                  value: 'Uniforme',
                  groupValue: pupa,
                  onChanged: (String? value) {
                    setState(() {
                      pupa = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Irregular'),
                  value: 'Irregular',
                  groupValue: pupa,
                  onChanged: (String? value) {
                    setState(() {
                      pupa = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Ausente'),
                  value: 'Ausente',
                  groupValue: pupa,
                  onChanged: (String? value) {
                    setState(() {
                      pupa = value;
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
                  groupValue: healthStatus,
                  onChanged: (String? value) {
                    setState(() {
                      healthStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Doente'),
                  value: 'Doente',
                  groupValue: healthStatus,
                  onChanged: (String? value) {
                    setState(() {
                      healthStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Mortas'),
                  value: 'Mortas',
                  groupValue: healthStatus,
                  onChanged: (String? value) {
                    setState(() {
                      healthStatus = value;
                    });
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
                        'Nova Inspeção',
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                      onPressed: _submitForm,
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
