 import 'package:flutter/material.dart';
 import '../services/fake_db.dart';
 import '../services/session_service.dart';
 import '../services/location_service.dart'; // ✅ ADD THIS

 class VoteScreen extends StatefulWidget {
   final Map user;

   VoteScreen({required this.user});

   @override
   State<VoteScreen> createState() => _VoteScreenState();
 }

 class _VoteScreenState extends State<VoteScreen> {

   // 👤 GET CURRENT USER (SAFE)
   Map<String, dynamic> get currentUser {
     return Map<String, dynamic>.from(
       SessionService.currentUser ?? widget.user,
     );
   }

   // 🗳 VOTE FUNCTION WITH LOCATION CHECK
   void vote(int candidateId) async {

     var user = currentUser;

     // 🚫 already voted
     if (user["hasVoted"] == true) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("You have already voted")),
       );
       return;
     }

     // 📍 GET REAL LOCATION
     String? realRegion = await LocationService.getUserRegion();

     if (realRegion == null) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Unable to get your location")),
       );
       return;
     }

     // 🧠 DEBUG (optional - remove later)
     print("REAL REGION: $realRegion");
     print("USER REGION: ${user["region"]}");

     // ❌ REGION MISMATCH BLOCK
     if (realRegion.toLowerCase() != user["region"].toLowerCase()) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text("You must be in your registered region to vote"),
           backgroundColor: Colors.red,
         ),
       );
       return;
     }

     // ✅ SAVE VOTE
     FakeDB.votes.add({
       "userId": user["id"],
       "candidateId": candidateId,
     });

     // 🔒 UPDATE USER IN DB
     for (var u in FakeDB.users) {
       if (u["id"] == user["id"]) {
         u["hasVoted"] = true;
       }
     }

     // 🔄 UPDATE SESSION
     SessionService.currentUser = {
       ...user,
       "hasVoted": true,
     };

     setState(() {});

     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text("Vote recorded successfully"),
         backgroundColor: Colors.green,
       ),
     );
   }

   @override
   Widget build(BuildContext context) {

     var user = currentUser;

     // 🌍 FILTER BY REGION
     var candidates = FakeDB.candidates
         .where((c) => c["region"] == user["region"])
         .toList();

     return Scaffold(
       appBar: AppBar(
         title: Text("Vote Candidates"),
         centerTitle: true,
       ),

       body: Padding(
         padding: EdgeInsets.all(16),
         child: Column(
           children: [

             // ℹ️ INFO
             Card(
               color: Colors.green[50],
               child: Padding(
                 padding: EdgeInsets.all(12),
                 child: Text(
                   user["hasVoted"] == true
                       ? "You have already voted."
                       : "Select one candidate. Voting is final.",
                 ),
               ),
             ),

             SizedBox(height: 10),

             // 📋 LIST
             Expanded(
               child: candidates.isEmpty
                   ? Center(child: Text("No candidates available"))
                   : ListView.builder(
                       itemCount: candidates.length,
                       itemBuilder: (context, index) {

                         var c = candidates[index];

                         return Card(
                           margin: EdgeInsets.symmetric(vertical: 8),
                           child: ListTile(
                             leading: CircleAvatar(
                               backgroundColor: Colors.green,
                               child: Text(c["name"][0]),
                             ),

                             title: Text(
                               c["name"],
                               style: TextStyle(fontWeight: FontWeight.bold),
                             ),

                             subtitle: Text(
                               "${c["party"]} • ${c["region"]}",
                             ),

                             trailing: ElevatedButton(
                               onPressed: user["hasVoted"]
                                   ? null
                                   : () => vote(c["id"]),

                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.green,
                               ),

                               child: Text("Vote"),
                             ),
                           ),
                         );
                       },
                     ),
             ),
           ],
         ),
       ),
     );
   }
 }