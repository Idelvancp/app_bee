import 'package:app_bee/components/appDrawer.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/providers/floralResourceProvider.dart';
import 'package:app_bee/providers/typeHiveProvider.dart';
import 'package:app_bee/providers/specieProvider.dart';
import 'package:app_bee/providers/honeyBoxProvider.dart';
import 'package:app_bee/providers/hiveProvider.dart';
import 'package:app_bee/screens/floralResource/floralResourceScreen.dart';
import 'package:app_bee/screens/floralResource/floralResourceFormScreen.dart';
import 'package:app_bee/screens/honeyBox/honeyBoxFormScreen.dart';
import 'package:app_bee/screens/honeyBox/honeyBoxesScreen.dart';
import 'package:app_bee/screens/reports/reportsScreen.dart';
import 'package:app_bee/screens/typesHive/typesHivesScreen.dart';
import 'package:app_bee/screens/typesHive/typeHiveFormScreen.dart';
import 'package:app_bee/screens/hive/hivesScreen.dart';
import 'package:app_bee/screens/hive/hiveFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/ apiary/apiariesScreen.dart';
import 'screens/ apiary/apiaryForm.dart';
import 'screens/ apiary/apiaryDetailsScreen.dart';
import 'screens/specie/speciesScreen.dart';
import 'screens/specie/specieFormScreen.dart';
import 'models/apiaryList.dart';
import 'routes/appRoute.dart';

void main() => runApp(BeeApp());

class BeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiaryList(),
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

          // AppRoutes.APIARY_DETAILS: (ctx) => ApiaryDetailsScreen(),
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
  int _selectedScreenIndex = 0;

  final List<Map<String, dynamic>> _screens = [
    {'title': 'Apiários', 'screen': ApiariesScreen()},
    {'title': 'Relatórios', 'screen': ReportsScreen()},

    {'title': 'Formulário Espécie', 'screen': SpecieFormScreen()},
    {'title': 'Espécies', 'screen': SpeciesScreen()},
    {'title': 'Lista de Categorias', 'screen': ApiariesScreen()},
    {'title': 'Tipos de Colméias', 'screen': TypesHivesScreen()},
    {'title': 'Recursos Florais', 'screen': ApiariesScreen()},
    {'title': 'Fomulários Recursos Florais', 'screen': TypesHivesScreen()},
    {'title': 'Caixas de Abelhas', 'screen': HoneyBoxesScreen()},
    {'title': 'Cadastrar Caixa de Abelha', 'screen': HoneyBoxFormScreen()},
    {'title': 'Colmeias', 'screen': HivesScreen()},
    {'title': 'Cadastrar Colmeia', 'screen': HiveFormScreen()},

    // {'title': 'Detalhes Apiários', 'screen': ApiaryDetailsScreen()},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]['title']),
        centerTitle: true,
      ),
      body: _screens[_selectedScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Apiários',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Relatórios',
          ),
        ],
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
      ),
      drawer: AppDrawer(
          //onSelectItem: _selectScreen,
          ),
    );
  }
}
