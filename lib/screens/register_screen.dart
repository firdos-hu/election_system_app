 import 'package:flutter/material.dart';
 import '../services/fake_db.dart';

 class RegisterScreen extends StatefulWidget {
   @override
   State<RegisterScreen> createState() => _RegisterScreenState();
 }

 class _RegisterScreenState extends State<RegisterScreen> {

   final idController = TextEditingController();
   final passwordController = TextEditingController();
   final regionController = TextEditingController();

   void registerUser() {

     String id = idController.text.trim();
     String password = passwordController.text.trim();
     String region = regionController.text.trim();

     // validation
     if (id.isEmpty || password.isEmpty || region.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("All fields are required")),
       );
       return;
     }

     // check duplicate user
     bool exists = FakeDB.users.any((u) => u["id"] == id);

     if (exists) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("User already exists")),
       );
       return;
     }

     // add user
     FakeDB.registerUser({
       "id": id,
       "password": password,
       "region": region,
       "role": "user",
     });

     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Account created successfully")),
     );

     Navigator.pop(context);
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text("Register")),

       body: Padding(
         padding: EdgeInsets.all(16),
         child: Column(
           children: [

             TextField(
               controller: idController,
               decoration: InputDecoration(labelText: "ID"),
             ),

             TextField(
               controller: passwordController,
               obscureText: true,
               decoration: InputDecoration(labelText: "Password"),
             ),

             TextField(
               controller: regionController,
               decoration: InputDecoration(labelText: "Region"),
             ),

             SizedBox(height: 20),

             ElevatedButton(
               onPressed: registerUser,
               child: Text("Create Account"),
             ),
           ],
         ),
       ),
     );
   }
 }