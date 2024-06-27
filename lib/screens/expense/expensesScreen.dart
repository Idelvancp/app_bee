import 'package:app_bee/components/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/expenseProvider.dart';
import 'package:app_bee/routes/appRoute.dart';

class ExpensesScreen extends StatefulWidget {
  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  Widget build(BuildContext context) {
    final ExpenseProvider expenses = Provider.of(context);
    final expensesList = expenses.expenses; // Obter a lista de despesas
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas"),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: expensesList.map((expense) {
          return ListTile(
            title: Text(expense.date.toIso8601String() +
                ' - \$' +
                expense.cost.toString()),
            subtitle: Text('Tipo: ' + expense.typeExpenseId.toString()),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple, // Cor do botão
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.EXPENSE_FORM);
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
