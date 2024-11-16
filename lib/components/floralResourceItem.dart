import 'package:app_bee/providers/floralResourceProvider.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/floralResource.dart';
import '../routes/appRoute.dart';

class FloralResourceItem extends StatelessWidget {
  final FloralResource floralResource;

  const FloralResourceItem(this.floralResource);
/*
  void _selectFloralResource(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.APIARY_DETAILS,
      arguments: specie,
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      color: Colors.grey[200],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Alinha os elementos nas extremidades da linha
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 10), // Adiciona espaçamento à esquerda
              child: Text(
                floralResource.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
            ),
            // Container para os ícones de ações, alinhados à direita
            Row(
              mainAxisSize:
                  MainAxisSize.min, // Torna o Row tão pequeno quanto possível
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.orange),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.SPECIE_FORM,
                      arguments: floralResource,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
