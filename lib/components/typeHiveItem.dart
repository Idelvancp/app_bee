import 'package:flutter/material.dart';
import 'package:app_bee/models/typeHive.dart';
import '../routes/appRoute.dart';

class TypeHiveItem extends StatelessWidget {
  final TypeHive typeHive;

  const TypeHiveItem(this.typeHive);

  void _selectTypeHive(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.APIARY_DETAILS,
      arguments: typeHive,
    );
  }

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
                typeHive.name,
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
                      arguments: typeHive,
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
