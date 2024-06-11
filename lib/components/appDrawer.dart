import 'package:app_bee/routes/appRoute.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Menu'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Spécie'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Spécie'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.SPECIE_INDEX,
              );
            },
          ),
        ],
      ),
    );
  }
}
