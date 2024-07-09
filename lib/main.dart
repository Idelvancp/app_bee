import 'package:app_bee/components/appDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/providers/floralResourceProvider.dart';
import 'package:app_bee/providers/typeExpenseProvider.dart';
import 'package:app_bee/providers/typeHiveProvider.dart';
import 'package:app_bee/providers/typeInspectionProvider.dart';
import 'package:app_bee/providers/inspectionProvider.dart';
import 'package:app_bee/providers/specieProvider.dart';
import 'package:app_bee/providers/honeyBoxProvider.dart';
import 'package:app_bee/providers/hiveProvider.dart';
import 'package:app_bee/providers/expenseProvider.dart';
import 'package:app_bee/screens/floralResource/floralResourceScreen.dart';
import 'package:app_bee/screens/floralResource/floralResourceFormScreen.dart';
import 'package:app_bee/screens/honeyBox/honeyBoxFormScreen.dart';
import 'package:app_bee/screens/honeyBox/honeyBoxesScreen.dart';
import 'package:app_bee/screens/reports/reportsScreen.dart';
import 'package:app_bee/screens/typeInspection/typeInspectionFormScreen.dart';
import 'package:app_bee/screens/typeInspection/typeInspectionScreen.dart';
import 'package:app_bee/screens/typesExpenses/typeExpenseFormScreen.dart';
import 'package:app_bee/screens/typesHive/typesHivesScreen.dart';
import 'package:app_bee/screens/typesHive/typeHiveFormScreen.dart';
import 'package:app_bee/screens/hive/hivesScreen.dart';
import 'package:app_bee/screens/hive/hiveFormScreen.dart';
import 'package:app_bee/screens/hive/hiveDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_bee/screens/login/loginScreen.dart';
import 'screens/ apiary/apiariesScreen.dart';
import 'screens/ apiary/apiaryForm.dart';
import 'screens/ apiary/apiaryDetailsScreen.dart';
import 'screens/specie/speciesScreen.dart';
import 'screens/specie/specieFormScreen.dart';
import 'screens/inspection/inspectionFormScreen.dart';
import 'screens/inspection/inspectionsScreen.dart';
import 'package:app_bee/screens/inspection/inspectionForm2Screen.dart';
import 'package:app_bee/screens/typesExpenses/typesExpensesScreen.dart';
import 'screens/inspection/inspectionDetailsScreen.dart';
import 'package:app_bee/screens/typesExpenses/typeExpenseFormScreen.dart';
import 'package:app_bee/screens/expense/expensesScreen.dart';
import 'package:app_bee/screens/expense/expenseFormScreen.dart';
import 'package:app_bee/screens/collect/collectScreen.dart';
import 'package:app_bee/screens/collect/collectFormScreen.dart';
import 'package:app_bee/providers/apiaryProvider.dart';
import 'package:app_bee/providers/collectProvider.dart';
import 'components/reportsNavigator.dart';
import 'package:app_bee/screens/reports/productsReportsScreen.dart';
import 'package:app_bee/screens/reports/honeyReportScreen.dart';
import 'routes/appRoute.dart';

void main() => runApp(BeeApp());

class BeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiaryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SpecieProvider()..loadSpecies(),
        ),
        ChangeNotifierProvider(
          create: (_) => TypeHiveProvider()..loadTypesHives(),
        ),
        ChangeNotifierProvider(
          create: (_) => FloralResourceProvider()..loadFloralResources(),
        ),
        ChangeNotifierProvider(
          create: (_) => HoneyBoxProvider()..loadHoneyBoxes(),
        ),
        ChangeNotifierProvider(
          create: (_) => HiveProvider()..loadHives(),
        ),
        ChangeNotifierProvider(
          create: (_) => TypeInspectionProvider()..loadTypeInspections(),
        ),
        ChangeNotifierProvider(
          create: (_) => InspectionProvider()..loadInspections(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExpenseProvider()..loadExpenses(),
        ),
        ChangeNotifierProvider(
          create: (_) => TypeExpenseProvider()..loadTypeExpenses(),
        ),
        ChangeNotifierProvider(
          create: (_) => CollectProvider()..loadCollects(),
        ),
      ],
      child: MaterialApp(
        title: 'App Bee',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.purple,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        routes: {
          AppRoutes.HOME: (ctx) => MainScreen(),
          AppRoutes.REPORT_SCREEN: (ctx) => ReportsScreen(),
          AppRoutes.APIARY_FORM: (ctx) => ApiaryForm(),
          AppRoutes.APIARY_DETAILS: (ctx) => ApiaryDetailsScreen(),
          AppRoutes.SPECIE_FORM: (ctx) => SpecieFormScreen(),
          AppRoutes.SPECIE_INDEX: (ctx) => SpeciesScreen(),
          AppRoutes.TYPES_HIVES_INDEX: (ctx) => TypesHivesScreen(),
          AppRoutes.TYPES_HIVES_FORM: (ctx) => TypeHiveFormScreen(),
          AppRoutes.FLORAL_RESOURCES_INDEX: (ctx) => FloralResourcesScreen(),
          AppRoutes.FLORAL_RESOURCES_FORM: (ctx) => FloralResourceFormScreen(),
          AppRoutes.HONEY_BOXES_INDEX: (ctx) => HoneyBoxesScreen(),
          AppRoutes.HONEY_BOX_FORM: (ctx) => HoneyBoxFormScreen(),
          AppRoutes.HIVES_INDEX: (ctx) => HivesScreen(),
          AppRoutes.HIVE_FORM: (ctx) => HiveFormScreen(),
          AppRoutes.HIVE_DETAILS: (ctx) => HiveDetailsScreen(),
          AppRoutes.TYPES_INSPECTIONS_INDEX: (ctx) => TypesInspectionsScreen(),
          AppRoutes.TYPE_INSPECTION_FORM: (ctx) => TypeInspectionFormScreen(),
          AppRoutes.INSPECTIONS_DETAILS: (ctx) => InspectionDetailsScreen(),
          AppRoutes.INSPECTIONS_INDEX: (ctx) => InspectionsScreen(),
          AppRoutes.INSPECTION_FORM: (ctx) => InspectionFormScreen(),
          AppRoutes.INSPECTION_FORM2: (ctx) => InspectionForm2Screen(),
          AppRoutes.TYPE_EXPENSE_FORM: (ctx) => TypeExpenseFormScreen(),
          AppRoutes.TYPES_EXPENSES_INDEX: (ctx) => TypesExpensesScreen(),
          AppRoutes.EXPENSES_INDEX: (ctx) => ExpensesScreen(),
          AppRoutes.EXPENSE_FORM: (ctx) => ExpenseFormScreen(),
          AppRoutes.COLLECTS_INDEX: (ctx) => CollectsScreen(),
          AppRoutes.COLLECT_FORM: (ctx) => CollectFormScreen(),
          AppRoutes.PRODUCT_REPORT: (ctx) => ProductsReportsScreen(),
          AppRoutes.HONEY_REPORT: (ctx) => HoneyReportScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  int _selectedScreenIndex = 0;

  final List<Map<String, dynamic>> _screens = [
    {'title': 'Apiários', 'screen': ApiariesScreen()},
    {'title': 'Coletas', 'screen': CollectsScreen()},
    {'title': 'Despesas', 'screen': ExpensesScreen()},
    {'title': 'Relatórios', 'screen': ReportsNavigator()},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (!snapshot.hasData || !snapshot.data!) {
          return LoginScreen();
        } else {
          return Scaffold(
            appBar: _selectedScreenIndex == 0
                ? AppBar(
                    title: Text(_screens[_selectedScreenIndex]['title']),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () => _logout(context),
                      ),
                    ],
                  )
                : null,
            body: _screens[_selectedScreenIndex]['screen'],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.white70,
              selectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Apiários',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.collections),
                  label: 'Coletas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.money),
                  label: 'Despesas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Relatórios',
                ),
              ],
              currentIndex: _selectedScreenIndex,
              onTap: _selectScreen,
            ),
            drawer: AppDrawer(),
          );
        }
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
