import 'package:app_bee/screens/reports/reportsScreen.dart';
import 'package:app_bee/screens/reports/productsReportsScreen.dart';
import 'package:app_bee/screens/reports/expensesReportsScreen.dart';
import 'package:app_bee/screens/reports/honeyReportScreen.dart';

import 'package:app_bee/routes/appRoute.dart';
import 'package:flutter/material.dart';

class ReportsNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext _) => ReportsScreen();
            break;
          case AppRoutes.PRODUCT_REPORT:
            builder = (BuildContext _) => ProductsReportsScreen();
            break;
          /*
          case AppRoutes.HEALTH_REPORT:
            builder = (BuildContext _) => HealthReportScreen();
            break;
          case AppRoutes.INSPECTION_REPORT:
            builder = (BuildContext _) => InspectionReportScreen();
            break;
          case AppRoutes.FLORAL_RESOURCES_REPORT:
            builder = (BuildContext _) => FloralResourcesReportScreen();
            break;
          */
          case AppRoutes.EXPENSE_REPORT:
            builder = (BuildContext _) => ExpensesReportsScreen();
            break;
          case AppRoutes.HONEY_REPORT:
            builder = (BuildContext _) => HoneyReportScreen();
            break;
          /*
          case AppRoutes.HIVES_REPORT:
            builder = (BuildContext _) => HivesReportScreen();
            break;*/
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
