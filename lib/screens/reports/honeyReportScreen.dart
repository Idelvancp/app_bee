import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app_bee/providers/collectProvider.dart';
import 'package:provider/provider.dart';

class HoneyProductionByYear {
  final int year;
  final double amount;

  HoneyProductionByYear(this.year, this.amount);
}

class HoneyReportScreen extends StatefulWidget {
  @override
  State<HoneyReportScreen> createState() => _HoneyReportScreenState();
}

class _HoneyReportScreenState extends State<HoneyReportScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CollectProvider>(context, listen: false)
        .loadCollectHoneyByYear();
    Provider.of<CollectProvider>(context, listen: false)
        .loadCollectHoneyByApiary();
    Provider.of<CollectProvider>(context, listen: false)
        .loadCollectHoneyByHive();
  }

  @override
  Widget build(BuildContext context) {
    final collectProvider = Provider.of<CollectProvider>(context);
    final honeyByYear = collectProvider.collectHoneyByYear;
    final honeyByApiary = collectProvider.collectsHoneyByApiary;
    final honeyByHive = collectProvider.collectsHoneyByHive;

    final List<HoneyProductionByYear> data =
        honeyByYear.map<HoneyProductionByYear>((item) {
      int year = int.parse(item['year']);
      double honeyAmount = item['totalHoney'];
      return HoneyProductionByYear(year, honeyAmount);
    }).toList();

    final cardColor =
        Theme.of(context).cardColor; // Obtém a cor do fundo do card
    const paddingSize = 16.0; // Tamanho do padding
    const marginSize = 16.0; // Tamanho da margem
    const borderRadius = 16.0; // Raio do canto arredondado

    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório de Mel'),
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
                                .map((e) => e.amount)
                                .reduce((a, b) => a > b ? a : b) *
                            1.2,
                    barGroups: data
                        .map(
                          (HoneyProductionByYear item) => BarChartGroupData(
                            x: item.year,
                            barRods: [
                              BarChartRodData(
                                toY: item.amount,
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
                    children: honeyByApiary.map((apiary) {
                      return Card(
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiary['apiary_name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${apiary['total_honey'].toStringAsFixed(2)} kg',
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
                    itemCount: honeyByHive.length, // Número de itens na lista
                    itemBuilder: (ctx, index) {
                      final hive = honeyByHive[index];
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
                          title: Text(hive['hive_tag']),
                          subtitle: Text(
                            'Total Mel: ${hive['total_honey'].toStringAsFixed(2)} kg',
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
}

class HoneyProduction {
  final String year;
  final int amount;

  HoneyProduction(this.year, this.amount);
}
