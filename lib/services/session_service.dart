class SessionService {


  static Map<String, dynamic>? currentUser;


  static Map<String, dynamic>? currentAdmin;


  static void logoutUser() {
    currentUser = null;
  }


  static void logoutAdmin() {
    currentAdmin = null;
  }
}