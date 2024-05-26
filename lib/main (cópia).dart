import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await copyDatabase();
  runApp(MyApp());
}

Future<void> copyDatabase() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'bee.db');

  final exists = await databaseExists(path);

  if (!exists) {
    try {
      await Directory(dirname(path)).create(recursive: true);
      ByteData data = await rootBundle.load('assets/bee.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } catch (e) {
      print("Erro ao copiar o banco de dados: $e");
    }
  }
}

Future<Database> openMyDatabase() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'bee.db');
  return await openDatabase(path);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Database> database;

  @override
  void initState() {
    super.initState();
    database = openMyDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Database Example'),
      ),
      body: Center(
        child: FutureBuilder<Database>(
          future: database,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Database loaded successfully!');
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
