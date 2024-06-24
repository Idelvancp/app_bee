import 'package:app_bee/models/typeInspection.dart';
import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:app_bee/routes/appRoute.dart';

class InspectionForm3Screen extends StatefulWidget {
  const InspectionForm3Screen({Key? key}) : super(key: key);

  @override
  State<InspectionForm3Screen> createState() => _InspectionForm3State();
}

class _InspectionForm3State extends State<InspectionForm3Screen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  String? spawningQueen;

  void _toPagePopulationData(BuildContext context) {
    _formKey.currentState?.save();
    Navigator.of(context).pushNamed(
      AppRoutes.INSPECTION_FORM2,
      arguments: _formData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> hiveId =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("444444444444444444444444 ${hiveId}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Inspeção'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _toPagePopulationData,
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
                  decoration: InputDecoration(labelText: 'Quantidade de Mel'),
                  textInputAction: TextInputAction.next,
                  onSaved: (amountHoney) =>
                      _formData['amountHoney'] = amountHoney ?? '',
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Quantidade de Cera'),
                  textInputAction: TextInputAction.next,
                  onSaved: (amountWax) =>
                      _formData['amountWax'] = amountWax ?? '',
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Quantidade de Própolis'),
                  textInputAction: TextInputAction.next,
                  onSaved: (amountPropolis) =>
                      _formData['amountPropolis'] = amountPropolis ?? '',
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Quantidade de Geléia Real'),
                  textInputAction: TextInputAction.next,
                  onSaved: (amoutRoyalJelly) =>
                      _formData['amoutRoyalJelly'] = amoutRoyalJelly ?? '',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _toPagePopulationData(context),
                      child: Text('Próximo'),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
