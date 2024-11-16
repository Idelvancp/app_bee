import 'package:flutter/material.dart';
import '../models/typeExpense.dart';
import '../routes/appRoute.dart';
import 'package:app_bee/providers/typeExpenseProvider.dart';
import 'package:provider/provider.dart';

class TypeExpenseItem extends StatelessWidget {
  final TypeExpense typeExpense;

  const TypeExpenseItem(this.typeExpense);

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
            // Nome do TypeExpense alinhado à esquerda
            Text(
              typeExpense.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple,
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
                      AppRoutes.TYPE_EXPENSE_FORM,
                      arguments: typeExpense,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, typeExpense);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, TypeExpense typeExpense) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Você realmente deseja deletar este item?'),
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
              _deleteTypeExpense(
                  context, typeExpense); // Chama a função de deleção
            },
          ),
        ],
      ),
    );
  }

  void _deleteTypeExpense(BuildContext context, TypeExpense typeExpense) {
    // Aqui você chamaria o método do Provider para deletar o item
    Provider.of<TypeExpenseProvider>(context, listen: false)
        .deleteTypeExpense(typeExpense);
  }
}
