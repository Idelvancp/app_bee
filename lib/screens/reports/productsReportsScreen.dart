import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/routes/appRoute.dart';
import 'package:app_bee/components/appDrawer.dart';

class ProductsReportsScreen extends StatefulWidget {
  @override
  State<ProductsReportsScreen> createState() => ProductsReportsScreenState();
}

class ProductsReportsScreenState extends State<ProductsReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório de Produção de Produtos'),
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
            'Mel',
            Icons.bar_chart,
            AppRoutes.HONEY_REPORT,
          ),
          _buildReportCard(
            context,
            'Própolis',
            Icons.bar_chart,
            AppRoutes.PROPOLIS_REPORT,
          ),
          _buildReportCard(
            context,
            'Cera',
            Icons.bar_chart,
            AppRoutes.WAX_REPORT,
          ),
          _buildReportCard(
            context,
            'Geleia Real',
            Icons.bar_chart,
            AppRoutes.ROYAL_JELLY_REPORT,
          ),
        ],
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
