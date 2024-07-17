import 'package:app_bee/components/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/floralResourceProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/floralResourceItem.dart';

class FloralResourcesScreen extends StatefulWidget {
  @override
  State<FloralResourcesScreen> createState() => FloralResourcesScreenState();
}

class FloralResourcesScreenState extends State<FloralResourcesScreen> {
  Widget build(BuildContext context) {
    final FloralResourceProvider floralResources = Provider.of(context);
    final floralResourcesList = floralResources.floralResource;
    return Scaffold(
      appBar: AppBar(
        title: Text("Recursos Florais"),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 8 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: floralResourcesList.map((api) {
          return FloralResourceItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.FLORAL_RESOURCES_FORM);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
