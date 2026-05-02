import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/fake_db.dart';

class VoteChart extends StatelessWidget {

  Map<int, int> getVoteData() {
    Map<int, int> data = {};

    for (var v in FakeDB.votes) {
      int id = v["candidateId"];
      data[id] = (data[id] ?? 0) + 1;
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {

    var voteData = getVoteData();
    var candidates = FakeDB.candidates;

    if (voteData.isEmpty) {
      return Center(
        child: Text("No votes yet"),
      );
    }

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
              "Live Vote Distribution",
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
                  sections: voteData.entries.map((entry) {

                    var candidate = candidates.firstWhere(
                      (c) => c["id"] == entry.key,
                      orElse: () => {"name": "Unknown"},
                    );

                    return PieChartSectionData(
                      value: entry.value.toDouble(),
                      title: "${candidate["name"]}\n${entry.value}",
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),

                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}