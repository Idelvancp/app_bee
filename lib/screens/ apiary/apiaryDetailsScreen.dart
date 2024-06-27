import 'package:app_bee/data/dummy_data.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/apiaryProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import '../../components/apiaryItem.dart';

class ApiaryDetailsScreen extends StatelessWidget {
  const ApiaryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Apiary apiary = ModalRoute.of(context)!.settings.arguments as Apiary;
    /*final hives = DUMMY_HIVES.where((item) {
      return item.apiaryId == apiary.id;
    });*/
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk hiveDetails");

    final ApiaryProvider apiaries = Provider.of(context);
    final apiariesList = apiaries.apiary; // Obter a lista de apiários
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: apiariesList.map((api) {
          return ApiaryItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.APIARY_FORM);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
