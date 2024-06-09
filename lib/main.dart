import 'dart:math';
import 'package:flutter/material.dart';
import 'screens/ apiary/apiariesScreen.dart';
import 'screens/ apiary/apiaryForm.dart';
import 'routes/appRoute.dart';

void main() => runApp(BeeApp());

class BeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        AppRoutes.APIARY_FORM: (ctx) => ApiaryForm(),
      },
      debugShowCheckedModeBanner: false,
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
    {'title': 'Lista de Categorias', 'screen': ApiariesScreen()},
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
            label: 'Apiaries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Another', // Example
          ),
        ],
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
      ),
    );
  }
}
