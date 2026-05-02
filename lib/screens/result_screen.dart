 import 'package:flutter/material.dart';
 import '../services/fake_db.dart';

 class ResultScreen extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     // 🧮 Count votes per candidate
     Map<int, int> voteCount = {};

     for (var vote in FakeDB.votes) {
       int id = vote["candidateId"];
       voteCount[id] = (voteCount[id] ?? 0) + 1;
     }

     return Scaffold(
       appBar: AppBar(
         title: Text("Election Results"),
         centerTitle: true,
       ),

       body: Padding(
         padding: EdgeInsets.all(16),
         child: ListView.builder(
           itemCount: FakeDB.candidates.length,
           itemBuilder: (context, index) {
             var c = FakeDB.candidates[index];

             int count = voteCount[c["id"]] ?? 0;

             return Card(
               elevation: 4,
               margin: EdgeInsets.symmetric(vertical: 8),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12),
               ),
               child: ListTile(
                 leading: CircleAvatar(
                   backgroundColor: Colors.green,
                   child: Text(
                     c["name"][0],
                     style: TextStyle(color: Colors.white),
                   ),
                 ),

                 title: Text(
                   c["name"],
                   style: TextStyle(fontWeight: FontWeight.bold),
                 ),

                 subtitle: Text(
                   "Party: ${c["partyId"]} • Region: ${c["region"]}",
                 ),

                 trailing: Container(
                   padding: EdgeInsets.symmetric(
                     horizontal: 12,
                     vertical: 8,
                   ),
                   decoration: BoxDecoration(
                     color: Colors.green,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: Text(
                     "$count",
                     style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),
               ),
             );
           },
         ),
       ),
     );
   }
 }