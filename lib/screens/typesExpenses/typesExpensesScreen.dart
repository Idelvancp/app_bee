import 'package:app_bee/components/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/providers/typeExpenseProvider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/typeExpenseItem.dart';

class TypesExpensesScreen extends StatefulWidget {
  @override
  State<TypesExpensesScreen> createState() => _TypesExpensesScreenState();
}

class _TypesExpensesScreenState extends State<TypesExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    final TypeExpenseProvider typeExpenseProvider = Provider.of(context);
    final typeExpensesList =
        typeExpenseProvider.typeExpenses; // Obter a lista de tipos de despesa

    return Scaffold(
      appBar: AppBar(
        title: Text("Tipos de Despesa"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 8 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: typeExpensesList.map((api) {
          return TypeExpenseItem(api);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.TYPE_EXPENSE_FORM);
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, color: Colors.white),
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
