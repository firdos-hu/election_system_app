 import 'package:flutter/material.dart';
 import '../services/fake_db.dart';
 import '../services/auth_service.dart';
 import 'login_screen.dart';

 class AdminScreen extends StatefulWidget {
   @override
   State<AdminScreen> createState() => _AdminScreenState();
 }

 class _AdminScreenState extends State<AdminScreen> {

   final nameController = TextEditingController();
   final partyController = TextEditingController();
   final regionController = TextEditingController();

   // ➕ ADD CANDIDATE
   void addCandidate() {

     if (nameController.text.isEmpty ||
         partyController.text.isEmpty ||
         regionController.text.isEmpty) {
       return;
     }

     FakeDB.addCandidate(
       nameController.text,
       partyController.text,
       regionController.text,
     );

     setState(() {});

     nameController.clear();
     partyController.clear();
     regionController.clear();

     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Candidate Added")),
     );
   }

   // ❌ DELETE CANDIDATE
   void deleteCandidate(int index) {
     setState(() {
       FakeDB.candidates.removeAt(index);
     });
   }

   // 📊 TOTAL VOTES
   int get totalVotes => FakeDB.votes.length;

   // 👥 TOTAL USERS
   int get totalUsers => FakeDB.users.length;

   // 🚪 LOGOUT
   void logout() {
     AuthService.logout();
     Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(builder: (_) => LoginScreen()),
       (route) => false,
     );
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Admin Dashboard"),
         actions: [
           IconButton(onPressed: logout, icon: Icon(Icons.logout))
         ],
       ),

       body: SingleChildScrollView(
         padding: EdgeInsets.all(16),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [

             // 📊 STATS
             Row(
               children: [
                 Expanded(
                   child: Card(
                     child: ListTile(
                       title: Text("$totalUsers"),
                       subtitle: Text("Users"),
                     ),
                   ),
                 ),
                 Expanded(
                   child: Card(
                     child: ListTile(
                       title: Text("$totalVotes"),
                       subtitle: Text("Votes"),
                     ),
                   ),
                 ),
               ],
             ),

             SizedBox(height: 20),

             // ➕ ADD CANDIDATE FORM
             Text("Add Candidate",
                 style: TextStyle(fontWeight: FontWeight.bold)),

             TextField(
               controller: nameController,
               decoration: InputDecoration(labelText: "Name"),
             ),

             TextField(
               controller: partyController,
               decoration: InputDecoration(labelText: "Party"),
             ),

             TextField(
               controller: regionController,
               decoration: InputDecoration(labelText: "Region"),
             ),

             SizedBox(height: 10),

             ElevatedButton(
               onPressed: addCandidate,
               child: Text("Add Candidate"),
             ),

             SizedBox(height: 20),

             // 📋 CANDIDATE LIST
             Text("Candidates",
                 style: TextStyle(fontWeight: FontWeight.bold)),

             ListView.builder(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemCount: FakeDB.candidates.length,
               itemBuilder: (context, index) {
                 var c = FakeDB.candidates[index];

                 return Card(
                   child: ListTile(
                     title: Text(c["name"]),
                     subtitle: Text("${c["party"]} • ${c["region"]}"),
                     trailing: IconButton(
                       icon: Icon(Icons.delete, color: Colors.red),
                       onPressed: () => deleteCandidate(index),
                     ),
                   ),
                 );
               },
             ),
           ],
         ),
       ),
     );
   }
 }