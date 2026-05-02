 class FakeDB {

   // 👤 USERS
   static List<Map<String, dynamic>> users = [
     {
       "id": "admin",
       "password": "admin123",
       "role": "admin",
       "region": "Admin",
       "hasVoted": false
     }
   ];

   // 🗳 VOTES
   static List<Map<String, dynamic>> votes = [];

   // 🧑‍💼 CANDIDATES (GLOBAL SHARED DATA)
   static List<Map<String, dynamic>> candidates = [];

   // ➕ ADD CANDIDATE (USED BY ADMIN)
   static void addCandidate(String name, String party, String region) {
     candidates.add({
       "id": candidates.length + 1,
       "name": name,
       "party": party,
       "region": region,
     });
   }

   // 👤 REGISTER USER
   static void registerUser(Map<String, dynamic> user) {
     users.add({
       "id": user["id"].trim(),
       "password": user["password"].trim(),
       "role": user["role"] ?? "user",
       "region": user["region"] ?? "",
       "hasVoted": false,
     });
   }
 }