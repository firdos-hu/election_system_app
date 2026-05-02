 import 'package:flutter/material.dart';

 import 'screens/login_screen.dart';
 import 'screens/home_screen.dart';
 import 'services/storage_service.dart';

 void main() {
   runApp(ElectionApp());
 }

 class ElectionApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Election System',

       home: FutureBuilder(
         future: StorageService.getUser(),
         builder: (context, snapshot) {
           // ⏳ Loading state
           if (snapshot.connectionState == ConnectionState.waiting) {
             return Scaffold(
               body: Center(child: CircularProgressIndicator()),
             );
           }

           // 🚫 No saved user → go to login
           if (!snapshot.hasData || snapshot.data == null) {
             return LoginScreen();
           }

           // ✅ User exists → go to home
           var user = snapshot.data as Map;

           return HomeScreen(user: user);
         },
       ),
     );
   }
 }