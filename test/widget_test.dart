// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_bee/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}





import 'package:flutter/material.dart';

class HiveDetailsScreen extends StatelessWidget {
  // Esta função deve ser a sua função getHiveDetails
  Future<List<Map<String, dynamic>>> getHiveDetails() async {
    // Simulação de chamada de banco de dados - substitua pelo seu código real
    await Future.delayed(Duration(seconds: 2));
    return [
      {
        'tag': 'Box 1',
        'species_name': 'Apis Mellifera',
        'apiary_name': 'Apiary 1',
        'specie_created_at': '2023-01-01',
        'specie_updated_at': '2023-01-02',
        'apiary_city_id': 1,
        'apiary_state_id': 1,
        'apiary_created_at': '2023-01-01',
        'apiary_updated_at': '2023-01-02'
      },
      {
        'tag': 'Box 2',
        'species_name': 'Apis Cerana',
        'apiary_name': 'Apiary 2',
        'specie_created_at': '2023-02-01',
        'specie_updated_at': '2023-02-02',
        'apiary_city_id': 2,
        'apiary_state_id': 2,
        'apiary_created_at': '2023-02-01',
        'apiary_updated_at': '2023-02-02'
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Details'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getHiveDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final hiveDetails = snapshot.data!;
            return ListView.builder(
              itemCount: hiveDetails.length,
              itemBuilder: (context, index) {
                final hive = hiveDetails[index];
                return ListTile(
                  title: Text('Tag: ${hive['tag']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Species: ${hive['species_name']}'),
                      Text('Apiary: ${hive['apiary_name']}'),
                      Text('Created at: ${hive['specie_created_at']}'),
                      Text('Updated at: ${hive['specie_updated_at']}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: HiveDetailsScreen()));



