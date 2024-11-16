import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/collect.dart';
import '../providers/collectProvider.dart';
import 'package:app_bee/ultils/formatDate.dart';

class CollectItem extends StatelessWidget {
  final Map<String, dynamic> collect;

  const CollectItem(this.collect);

  void _showDeleteConfirmationDialog(BuildContext context, Collect collect) {
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
              _deleteCollect(context, collect); // Chama a função de deleção
            },
          ),
        ],
      ),
    );
  }

  void _deleteCollect(BuildContext context, Collect collect) {
    Provider.of<CollectProvider>(context, listen: false).deleteCollect(collect);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${collect['apiary_name']}, ${collect['tag']}, ${collect['specie_name']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Data: ${formatDate(collect['date'])}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Mel: ${collect['honey'].toStringAsFixed(2)} kg, Própolis: ${collect['propolis'].toStringAsFixed(2)} kg',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Cera: ${collect['wax'].toStringAsFixed(2)} kg, Geléia Real: ${collect['royal_jelly'].toStringAsFixed(2)} kg',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
