import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/specie.dart';
import '../providers/specieProvider.dart';
import '../routes/appRoute.dart';

class SpecieItem extends StatelessWidget {
  final Specie specie;

  const SpecieItem(this.specie);

  void _showDeleteConfirmationDialog(BuildContext context, Specie specie) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Você realmente deseja deletar esta espécie?'),
        actions: <Widget>[
          TextButton(
            child: Text('Não'),
            onPressed: () {
              Navigator.of(ctx).pop(); // Fecha o diálogo sem fazer nada
            },
          ),
          TextButton(
            child: Text('Sim'),
            onPressed: () {
              Navigator.of(ctx).pop(); // Fecha o diálogo
              _deleteSpecie(context, specie); // Chama a função de deleção
            },
          ),
        ],
      ),
    );
  }

  void _deleteSpecie(BuildContext context, Specie specie) {
    Provider.of<SpecieProvider>(context, listen: false).deleteSpecie(specie);
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
            // Nome da Espécie e Quantidade de Colmeias alinhados à esquerda
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  specie.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ],
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
                      arguments: specie,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, specie);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
