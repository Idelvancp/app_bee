import 'package:app_bee/components/appDrawer.dart';
import 'package:app_bee/components/expenseItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/expenseProvider.dart';
import 'package:app_bee/routes/appRoute.dart';

class ExpensesScreen extends StatefulWidget {
  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseProvider>(context, listen: false).loadExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ExpenseProvider expenses = Provider.of<ExpenseProvider>(context);
    final List<Map<String, dynamic>> expensesList = expenses.expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas'),
        centerTitle: true,
      ),
      body: expensesList.isEmpty
          ? Center(
              child: Text(
                'Nenhuma despesa cadastrada',
                style: TextStyle(fontSize: 20),
              ),
            )
          : GridView(
              padding: const EdgeInsets.all(25),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 4 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: expensesList.map((expense) {
                return ExpenseItem(expense);
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.EXPENSE_FORM);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
