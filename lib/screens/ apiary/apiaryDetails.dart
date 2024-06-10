import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/models/apiaryList.dart';
import 'package:app_bee/routes/appRoute.dart';
import '../../components/apiaryItem.dart';

class ApiariesScreen extends StatefulWidget {
  @override
  State<ApiariesScreen> createState() => ApiariesScreenState();
}

class ApiariesScreenState extends State<ApiariesScreen> {
  Widget build(BuildContext context) {
    final ApiaryList apiaries = Provider.of(context);
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
