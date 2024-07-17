import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final expenses = ExpenseProvider().loadExpenses();
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
              Text(
                'Despesa: ${expense['type_expense_name'].toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
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
