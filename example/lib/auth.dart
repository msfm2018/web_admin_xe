
import 'package:rxflare/rxflare.dart';

class Auth {
  static final isLoggedIn = false.obs;

  static void login() {
    isLoggedIn.value = true;
  }

  static void logout() {
    isLoggedIn.value = false;
  }
}