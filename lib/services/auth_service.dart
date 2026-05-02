 import 'fake_db.dart';

 class AuthService {

   static Map<String, dynamic>? currentUser;


   static bool login(String id, String password) {

     for (var user in FakeDB.users) {
       if (user["id"].toString().trim() == id.trim() &&
           user["password"].toString().trim() == password.trim()) {

         currentUser = user;
         return true;
       }
     }

     return false;
   }


   static void logout() {
     currentUser = null;
   }
 }