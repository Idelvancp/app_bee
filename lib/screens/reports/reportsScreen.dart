import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';

class ReportsScreen extends StatefulWidget {
  @override
  State<ReportsScreen> createState() => ReportsScreenState();
}

class ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios'),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          _buildReportCard(
            context,
            'Produtos',
            Icons.bar_chart,
            AppRoutes.PRODUCT_REPORT,
          ),
          _buildReportCard(
            context,
            'Saúde das Colmeias',
            Icons.health_and_safety,
            AppRoutes.HEALTH_REPORT,
          ),
          _buildReportCard(
            context,
            'Inspeções',
            Icons.search,
            AppRoutes.INSPECTION_REPORT,
          ),
          _buildReportCard(
            context,
            'Recursos Florais',
            Icons.local_florist,
            AppRoutes.FLORAL_RESOURCES_REPORT,
          ),
          _buildReportCard(
            context,
            'Despesas',
            Icons.money,
            AppRoutes.EXPENSE_REPORT,
          ),
          _buildReportCard(
            context,
            'Enxames e Colmeias',
            Icons.hive,
            AppRoutes.HIVES_REPORT,
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
