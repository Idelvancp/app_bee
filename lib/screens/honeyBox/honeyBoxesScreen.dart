import 'package:app_bee/components/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/honeyBoxProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/honeyBoxItem.dart';

class HoneyBoxesScreen extends StatefulWidget {
  @override
  State<HoneyBoxesScreen> createState() => HoneyBoxesScreenState();
}

class HoneyBoxesScreenState extends State<HoneyBoxesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HoneyBoxProvider>(context, listen: false).loadHoneyBoxes();
    });
  }

  Widget build(BuildContext context) {
    final HoneyBoxProvider honeyBoxes = Provider.of(context);
    final honeyBoxesList =
        honeyBoxes.honeyBoxesWithTypeName; // Obter a lista de apiários
    return Scaffold(
      appBar: AppBar(
        title: Text("Caixas de Abelhas"),
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
        children: honeyBoxesList.map((api) {
          return HoneyBoxItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.HONEY_BOX_FORM);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
