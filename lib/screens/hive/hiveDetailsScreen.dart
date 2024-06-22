import 'package:app_bee/data/dummy_data.dart';
import 'package:app_bee/models/hive.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/routes/appRoute.dart';
import '../../components/hiveItem.dart';
import 'package:app_bee/providers/hiveProvider.dart';

class HiveDetailsScreen extends StatelessWidget {
  const HiveDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List = ModalRoute.of(context)!.settings.arguments;

    /*final hives = DUMMY_HIVES.where((item) {
      return item.hiveId == hive.id;
    });*/
    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk ${List.toString()}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhe Colmeia"),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
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
