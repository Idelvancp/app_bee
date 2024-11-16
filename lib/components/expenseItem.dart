import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/expenseProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/ultils/formatDate.dart';

class ExpenseItem extends StatelessWidget {
  final Map<String, dynamic> expense;

  const ExpenseItem(this.expense);

  void _selectExpense(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.HIVE_DETAILS,
      arguments: expense,
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, Map<String, dynamic> expense) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Você realmente deseja deletar esta despesa?'),
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
              _deleteExpense(context, expense); // Chama a função de deleção
            },
          ),
        ],
      ),
    );
  }

  void _deleteExpense(BuildContext context, Map<String, dynamic> expense) {
    Provider.of<ExpenseProvider>(context, listen: false)
        .deleteExpense(expense['id']);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectExpense(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${expense['type_expense_name'].toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.EXPENSE_FORM,
                            arguments: expense,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, expense);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                'Apiário: ${expense['apiary_name']}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
              Text(
                "Valor: ${expense['cost']}0 R\$",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
              Text(
                'Data: ${formatDate(expense['date'])}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
