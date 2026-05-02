import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/fake_db.dart';

class VoteChart extends StatelessWidget {

  Map<int, int> getVotes() {
    Map<int, int> data = {};

    for (var v in FakeDB.votes) {
      int id = v["candidateId"];
      data[id] = (data[id] ?? 0) + 1;
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {

    var votes = getVotes();

    if (votes.isEmpty) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: Text("No votes yet")),
        ),
      );
    }

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
              "Live Vote Results",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: votes.entries.map((entry) {

                    var candidate = FakeDB.candidates.firstWhere(
                      (c) => c["id"] == entry.key,
                      orElse: () => {"name": "Unknown"},
                    );

                    return PieChartSectionData(
                      value: entry.value.toDouble(),
                      title: "${candidate["name"]}\n${entry.value}",
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}