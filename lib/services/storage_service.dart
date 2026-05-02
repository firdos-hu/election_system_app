 import 'package:shared_preferences/shared_preferences.dart';

 class StorageService {
   // 💾 Save user session
   static Future<void> saveUser(Map user) async {
     final prefs = await SharedPreferences.getInstance();

     await prefs.setString("id", user["id"] ?? "");
     await prefs.setString("region", user["region"] ?? "");
     await prefs.setBool("hasVoted", user["hasVoted"] ?? false);

     // Optional: store role (admin/user)
     await prefs.setString("role", user["role"] ?? "user");
   }

   // 📥 Get saved user session
   static Future<Map?> getUser() async {
     final prefs = await SharedPreferences.getInstance();

     String? id = prefs.getString("id");

     if (id == null || id.isEmpty) {
       return null;
     }

     return {
       "id": id,
       "region": prefs.getString("region") ?? "",
       "hasVoted": prefs.getBool("hasVoted") ?? false,
       "role": prefs.getString("role") ?? "user",
     };
   }

   // 🚪 Logout (clear session)
   static Future<void> logout() async {
     final prefs = await SharedPreferences.getInstance();
     await prefs.clear();
   }
 }