import 'package:app_bee/routes/appRoute.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
//  final Function(int) onSelectItem; // Adicionar um callback

  //AppDrawer({Key? key, required this.onSelectItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Drawer'),
          ),
          Divider(),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.HOME,
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Spécie'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.SPECIE_INDEX,
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Tipos de Colmeias'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.TYPES_HIVES_INDEX,
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Recursos Florais'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.FLORAL_RESOURCES_INDEX,
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Caixas de Abelhas'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.HONEY_BOXES_INDEX,
              );
            },
          ),
        ],
      ),
    );
  }
}
