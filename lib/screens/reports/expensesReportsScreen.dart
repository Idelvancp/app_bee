import 'package:app_bee/providers/expenseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensesByYear {
  final int year;
  final double expense;

  ExpensesByYear(this.year, this.expense);
}

class ExpensesReportsScreen extends StatefulWidget {
  @override
  State<ExpensesReportsScreen> createState() => ExpensesReportsScreenState();
}

class ExpensesReportsScreenState extends State<ExpensesReportsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseProvider>(context, listen: false).loadExpensesByYear();
  }

  @override
  Widget build(BuildContext context) {
    final cardColor =
        Theme.of(context).cardColor; // Obtém a cor do fundo do card
    const paddingSize = 16.0; // Tamanho do padding
    const marginSize = 16.0; // Tamanho da margem
    const borderRadius = 16.0; // Raio do canto arredondado
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    var expenseByYear = expenseProvider.getTotalExpensesByYear();
    var expenseByApiary = expenseProvider.getTotalExpensesByApiary();
    var expenseByType = expenseProvider.getTotalExpensesByType();

    final List<ExpensesByYear> data = expenseByYear.entries.map((entry) {
      return ExpensesByYear(entry.key, entry.value);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final chartHeight =
              constraints.maxHeight / 3; // Um terço da altura da tela
          return Column(
            children: [
              Container(
                height: chartHeight,
                margin: const EdgeInsets.all(marginSize),
                padding: const EdgeInsets.all(paddingSize),
                decoration: BoxDecoration(
                  color: cardColor, // Aplica a cor de fundo do card
                  borderRadius: BorderRadius.circular(
                      borderRadius), // Cantos arredondados
                ),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: data.isEmpty
                        ? 0
                        : data
                                .map((e) => e.expense)
                                .reduce((a, b) => a > b ? a : b) *
                            1.2,
                    barGroups: data
                        .map(
                          (ExpensesByYear item) => BarChartGroupData(
                            x: item.year,
                            barRods: [
                              BarChartRodData(
                                toY: item.expense,
                                color: Colors.amber,
                                width: 20,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barTouchData: BarTouchData(
                      enabled: true,
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 5.0,
                              child: Text(
                                value.toInt().toString().substring(2),
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100, // Altura da Row com os cards
                padding: const EdgeInsets.symmetric(horizontal: paddingSize),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: expenseByApiary.entries.map((apiary) {
                      return Card(
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiary.key,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${apiary.value.toStringAsFixed(2)} R\$',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 8), // Pequeno espaço entre a Row e a ListView
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: marginSize),
                  padding: const EdgeInsets.symmetric(horizontal: paddingSize),
                  decoration: BoxDecoration(
                    color: cardColor, // Aplica a cor de fundo do card
                    borderRadius: BorderRadius.circular(
                        borderRadius), // Cantos arredondados
                  ),
                  child: ListView.builder(
                    itemCount: expenseByType.length, // Número de itens na lista
                    itemBuilder: (ctx, index) {
                      final expenseType = expenseByType.keys.elementAt(index);
                      final expenseTotal = expenseByType[expenseType];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          tileColor:
                              Colors.white, // Cor do fundo do item da lista
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Text(expenseType),
                          subtitle: Text(
                            'Total Gasto: R\$ ${expenseTotal}',
                          ),
                          trailing: Text('Detalhes'),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReportCard(
      BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
