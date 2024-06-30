import 'package:app_bee/components/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/collectProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/collectItem.dart';

class CollectsScreen extends StatefulWidget {
  @override
  State<CollectsScreen> createState() => CollectsScreenState();
}

class CollectsScreenState extends State<CollectsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CollectProvider>(context, listen: false).getCollectsScreen();
    });
  }

  Widget build(BuildContext context) {
    //final CollectProvider collects = Provider.of(context);
    // final collectsList = collects.collect; // Obter a lista de apiários
    final CollectProvider collectProvider = Provider.of(context);
    final colletsScreen = collectProvider.collectsScreen;

    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: colletsScreen.map((api) {
          return CollectItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.HIVES_INDEX);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
