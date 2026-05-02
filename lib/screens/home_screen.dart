 import 'package:flutter/material.dart';

 import 'vote_screen.dart';
 import 'result_screen.dart';
 import 'chart_screen.dart';
 import 'news_screen.dart';
 import 'login_screen.dart';

 import '../services/fake_db.dart';
 import '../services/session_service.dart';

 class HomeScreen extends StatelessWidget {

   final Map user;

   HomeScreen({required this.user});

   // 🚪 LOGOUT FUNCTION
   void logout(BuildContext context) {

     SessionService.currentUser = null;

     Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(builder: (_) => LoginScreen()),
       (route) => false,
     );
   }

   @override
   Widget build(BuildContext context) {

     // 🧠 SAFE USER (session OR passed user)
     var currentUser = SessionService.currentUser ??
         Map<String, dynamic>.from(user);

     bool isAdmin = currentUser["role"] == "admin";

     return Scaffold(
       backgroundColor: Colors.grey[100],

       appBar: AppBar(
         title: Text("Election Dashboard"),
         centerTitle: true,

         actions: [
           IconButton(
             icon: Icon(Icons.logout),
             onPressed: () => logout(context),
           ),
         ],
       ),

       body: SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.all(16),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [

               // 👤 USER CARD
               Card(
                 elevation: 5,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Padding(
                   padding: EdgeInsets.all(16),
                   child: Row(
                     children: [

                       CircleAvatar(
                         backgroundColor: Colors.green,
                         child: Text(
                           currentUser["id"][0].toUpperCase(),
                           style: TextStyle(color: Colors.white),
                         ),
                       ),

                       SizedBox(width: 15),

                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             "ID: ${currentUser["id"]}",
                             style: TextStyle(fontWeight: FontWeight.bold),
                           ),
                           Text("Region: ${currentUser["region"] ?? "N/A"}"),
                           Text(
                             isAdmin ? "Role: Admin" : "Role: Voter",
                             style: TextStyle(color: Colors.grey),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),

               SizedBox(height: 20),

               Text(
                 "Dashboard",
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                 ),
               ),

               SizedBox(height: 15),

               // 🗳 VOTE
               SizedBox(
                 width: double.infinity,
                 height: 50,
                 child: ElevatedButton.icon(
                   icon: Icon(Icons.how_to_vote),
                   label: Text("Vote Now"),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.green,
                   ),
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (_) => VoteScreen(user: currentUser),
                       ),
                     );
                   },
                 ),
               ),

               SizedBox(height: 10),

               // 📊 RESULTS
               SizedBox(
                 width: double.infinity,
                 height: 50,
                 child: ElevatedButton.icon(
                   icon: Icon(Icons.list),
                   label: Text("View Results"),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.blue,
                   ),
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (_) => ResultScreen(),
                       ),
                     );
                   },
                 ),
               ),

               SizedBox(height: 10),

               // 📈 CHART
               SizedBox(
                 width: double.infinity,
                 height: 50,
                 child: ElevatedButton.icon(
                   icon: Icon(Icons.bar_chart),
                   label: Text("Live Chart"),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.orange,
                   ),
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (_) => ChartScreen(),
                       ),
                     );
                   },
                 ),
               ),

               SizedBox(height: 10),

               // 📰 NEWS
               SizedBox(
                 width: double.infinity,
                 height: 50,
                 child: ElevatedButton.icon(
                   icon: Icon(Icons.public),
                   label: Text("Election News"),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.purple,
                   ),
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (_) => NewsScreen(),
                       ),
                     );
                   },
                 ),
               ),

               SizedBox(height: 20),

               // 👨‍💼 ADMIN PANEL
               if (isAdmin)
                 SizedBox(
                   width: double.infinity,
                   height: 50,
                   child: ElevatedButton.icon(
                     icon: Icon(Icons.admin_panel_settings),
                     label: Text("Admin Panel"),
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.red,
                     ),
                     onPressed: () {},
                   ),
                 ),

               SizedBox(height: 20),

               // ℹ INFO
               Card(
                 color: Colors.green[50],
                 child: Padding(
                   padding: EdgeInsets.all(12),
                   child: Text(
                     "You can vote only once. Results are updated from system data.",
                   ),
                 ),
               ),
             ],
           ),
         ),
       ),
     );
   }
 }