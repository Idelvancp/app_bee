import 'package:app_bee/routes/appRoute.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.purple[50], // Light purple background color
        child: Column(
          children: [
            AppBar(
              title: Text('Menu'),
              backgroundColor: Colors.purple, // Purple top bar
              automaticallyImplyLeading: false,
            ),
            Divider(color: Colors.purple),
            ListTile(
              leading: Icon(Icons.home, color: Colors.purple),
              title: Text('Home', style: TextStyle(color: Colors.purple)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.HOME,
                );
              },
            ),
            Divider(color: Colors.purple),
            ListTile(
              leading: Icon(Icons.bug_report, color: Colors.purple),
              title: Text('Espécies', style: TextStyle(color: Colors.purple)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.SPECIE_INDEX,
                );
              },
            ),
            Divider(color: Colors.purple),
            ListTile(
              leading: Icon(Icons.local_florist, color: Colors.purple),
              title: Text('Recursos Florais',
                  style: TextStyle(color: Colors.purple)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.FLORAL_RESOURCES_INDEX,
                );
              },
            ),
            Divider(color: Colors.purple),
            ListTile(
              leading: Icon(Icons.casino, color: Colors.purple),
              title: Text('Modelos de Caixa',
                  style: TextStyle(color: Colors.purple)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.TYPES_HIVES_INDEX,
                );
              },
            ),
            Divider(color: Colors.purple),
            ListTile(
              leading: Icon(Icons.hive, color: Colors.purple),
              title: Text('Caixas de Abelhas',
                  style: TextStyle(color: Colors.purple)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.HONEY_BOXES_INDEX,
                );
              },
            ),
            Divider(color: Colors.purple),
            ListTile(
              leading: Icon(Icons.waves, color: Colors.purple),
              title: Text('Colmeias', style: TextStyle(color: Colors.purple)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.HIVES_INDEX,
                );
              },
            ),
            Divider(color: Colors.purple),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.purple),
              title: Text('Tipos de Inspeções',
                  style: TextStyle(color: Colors.purple)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.TYPES_INSPECTIONS_INDEX,
                );
              },
            ),
            Divider(color: Colors.purple),
            ListTile(
              leading: Icon(Icons.list_alt, color: Colors.purple),
              title: Text('Inspeções', style: TextStyle(color: Colors.purple)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.INSPECTIONS_INDEX,
                );
              },
            ),
            Divider(color: Colors.purple),
            ListTile(
              leading: Icon(Icons.money, color: Colors.purple),
              title: Text('Tipos de Despesas',
                  style: TextStyle(color: Colors.purple)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.TYPES_EXPENSES_INDEX,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
