import 'dart:io'; // Importa classes para manipulação de arquivos e diretórios.
import 'package:flutter/material.dart'; // Importa a biblioteca principal do Flutter para construir a interface do usuário.
import 'package:flutter/services.dart'; // Importa classes para trabalhar com recursos do pacote, como assets.
import 'package:path/path.dart'; // Importa funções para manipulação de caminhos de arquivos.
import 'package:sqflite/sqflite.dart'; // Importa a biblioteca sqflite para trabalhar com bancos de dados SQLite.

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Garante que os widgets do Flutter sejam inicializados antes de qualquer outra coisa.
  await copyDatabase(); // Copia o banco de dados da pasta assets para o local de armazenamento do aplicativo.
  runApp(MyApp()); // Executa o aplicativo.
}

// Função para copiar o banco de dados da pasta assets para o local de armazenamento do aplicativo.
Future<void> copyDatabase() async {
  final databasePath =
      await getDatabasesPath(); // Obtém o caminho do diretório de bancos de dados.
  final path = join(databasePath,
      'mydatabase.db'); // Cria o caminho completo do arquivo do banco de dados.

  final exists = await databaseExists(
      path); // Verifica se o banco de dados já existe no local de armazenamento.

  if (!exists) {
    // Se o banco de dados não existir, copia-o dos assets.
    try {
      await Directory(dirname(path)).create(
          recursive:
              true); // Cria o diretório do banco de dados se ele não existir.
      ByteData data = await rootBundle
          .load('assets/mydatabase.db'); // Carrega o banco de dados dos assets.
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,
          data.lengthInBytes); // Converte os dados do banco de dados em uma lista de bytes.
      await File(path).writeAsBytes(bytes,
          flush:
              true); // Escreve os bytes no arquivo de banco de dados no local de armazenamento.
    } catch (e) {
      print(
          "Erro ao copiar o banco de dados: $e"); // Imprime uma mensagem de erro se a cópia falhar.
    }
  }
}

// Função para abrir o banco de dados.
Future<Database> openMyDatabase() async {
  final databasePath =
      await getDatabasesPath(); // Obtém o caminho do diretório de bancos de dados.
  final path = join(databasePath,
      'mydatabase.db'); // Cria o caminho completo do arquivo do banco de dados.
  return await openDatabase(
      path); // Abre o banco de dados e retorna a instância do banco de dados.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          MyHomePage(), // Define MyHomePage como a página inicial do aplicativo.
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() =>
      _MyHomePageState(); // Cria o estado para o widget MyHomePage.
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Database>
      database; // Declara uma variável para armazenar a instância futura do banco de dados.

  @override
  void initState() {
    super.initState();
    database =
        openMyDatabase(); // Inicializa a variável database com a função que abre o banco de dados.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Database Example'), // Define o título do AppBar.
      ),
      body: Center(
        child: FutureBuilder<Database>(
          future: database, // Define o Future a ser aguardado.
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Exibe uma mensagem de erro se o Future falhar.
              } else {
                return Text(
                    'Database loaded successfully!'); // Exibe uma mensagem de sucesso se o Future for concluído com êxito.
              }
            } else {
              return CircularProgressIndicator(); // Exibe um indicador de progresso enquanto o Future está em execução.
            }
          },
        ),
      ),
    );
  }
}
