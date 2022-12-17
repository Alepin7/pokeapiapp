import 'package:flutter/material.dart';

import '../service/firebase_services.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _Ranking();
}

class _Ranking extends State<Ranking> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The best ranking'),
      ),
      body: FutureBuilder<Json>(
        future: getRank(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final results = snapshot.data ?? {};
            return DataTable(
              columns: [
                DataColumn(
                  label: Text("Nombre"),
                ),
                DataColumn(
                  label: Text("Votos"),
                ),
              ],
              rows: [
                for (final result
                    in results.entries.toList()
                      ..sort(
                          (a, b) => b.value["voto"].compareTo(a.value["voto"])))
                  DataRow(
                    cells: [
                      DataCell(Text(result.key)),
                      DataCell(Text(result.value["voto"].toString())),
                    ],
                  ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error al obtener el ranking de pokemon");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
