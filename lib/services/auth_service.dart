import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';

  // Simpan data user saat register
  Future<bool> register(String username, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyUsername, username);
      await prefs.setString(_keyPassword, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Login dengan cek username dan password
  Future<bool> login(String username, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedUsername = prefs.getString(_keyUsername);
      final savedPassword = prefs.getString(_keyPassword);

      if (savedUsername == username && savedPassword == password) {
        await prefs.setBool(_keyIsLoggedIn, true);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  // Cek apakah user sudah login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Get username yang sedang login
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  // Cek apakah sudah ada user terdaftar
  Future<bool> hasRegisteredUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) != null;
  }
}
