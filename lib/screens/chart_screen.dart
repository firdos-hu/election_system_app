 import 'package:flutter/material.dart';
 import 'package:fl_chart/fl_chart.dart';
 import '../services/fake_db.dart';

 class ChartScreen extends StatelessWidget {

   Map<String, int> getVoteData() {
     Map<String, int> data = {};

     for (var candidate in FakeDB.candidates) {
       int count = FakeDB.votes
           .where((v) => v["candidateId"] == candidate["id"])
           .length;

       data[candidate["name"]] = count;
     }

     return data;
   }

   @override
   Widget build(BuildContext context) {
     final data = getVoteData();
     final keys = data.keys.toList();

     return Scaffold(
       appBar: AppBar(title: Text("Live Vote Analytics")),
       body: Padding(
         padding: EdgeInsets.all(20),
         child: Column(
           children: [

             Text(
               "Election Results Overview",
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
             ),

             SizedBox(height: 20),

             Expanded(
               child: BarChart(
                 BarChartData(
                   barGroups: List.generate(keys.length, (index) {
                     return BarChartGroupData(
                       x: index,
                       barRods: [
                         BarChartRodData(
                           toY: data[keys[index]]!.toDouble(),
                           width: 20,
                           color: Colors.green,
                         ),
                       ],
                     );
                   }),
                   titlesData: FlTitlesData(
                     bottomTitles: AxisTitles(
                       sideTitles: SideTitles(
                         showTitles: true,
                         getTitlesWidget: (value, meta) {
                           return Text(keys[value.toInt()]);
                         },
                       ),
                     ),
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),
     );
   }
 }