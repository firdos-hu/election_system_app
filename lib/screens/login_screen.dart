 import 'package:flutter/material.dart';
 import '../services/auth_service.dart';
 import '../services/fake_db.dart';

 import 'home_screen.dart';
 import 'admin_screen.dart';
 import 'register_screen.dart';

 class LoginScreen extends StatefulWidget {
   @override
   State<LoginScreen> createState() => _LoginScreenState();
 }

 class _LoginScreenState extends State<LoginScreen> {

   final idController = TextEditingController();
   final passwordController = TextEditingController();

   void login() {

     String id = idController.text.trim();
     String password = passwordController.text.trim();

     if (id.isEmpty || password.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Enter ID and Password")),
       );
       return;
     }

     bool success = AuthService.login(id, password);

     if (!success) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Invalid ID or Password")),
       );
       return;
     }

     var user = AuthService.currentUser!;

     if (user["role"] == "admin") {
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (_) => AdminScreen()),
       );
     } else {
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
       );
     }
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.grey[100],

       body: Center(
         child: Padding(
           padding: EdgeInsets.all(16),

           child: Card(
             elevation: 8,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(16),
             ),

             child: Padding(
               padding: EdgeInsets.all(20),

               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [

                   Icon(Icons.how_to_vote,
                       size: 60, color: Colors.green),

                   SizedBox(height: 10),

                   Text(
                     "Election Login",
                     style: TextStyle(
                       fontSize: 22,
                       fontWeight: FontWeight.bold,
                     ),
                   ),

                   SizedBox(height: 20),

                   TextField(
                     controller: idController,
                     decoration: InputDecoration(
                       labelText: "ID",
                       border: OutlineInputBorder(),
                     ),
                   ),

                   SizedBox(height: 10),

                   TextField(
                     controller: passwordController,
                     obscureText: true,
                     decoration: InputDecoration(
                       labelText: "Password",
                       border: OutlineInputBorder(),
                     ),
                   ),

                   SizedBox(height: 20),

                   SizedBox(
                     width: double.infinity,
                     height: 50,
                     child: ElevatedButton(
                       onPressed: login,
                       child: Text("Login"),
                     ),
                   ),

                   TextButton(
                     onPressed: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (_) => RegisterScreen(),
                         ),
                       );
                     },
                     child: Text("Create Account"),
                   ),
                 ],
               ),
             ),
           ),
         ),
       ),
     );
   }
 }