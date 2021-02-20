import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepo {
  static AuthenticationRepo _authenticationRepo;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  factory AuthenticationRepo() {
    if (_authenticationRepo == null) {
      _authenticationRepo = AuthenticationRepo._internal();
    }
    return _authenticationRepo;
  }

  AuthenticationRepo._internal();

  Future<User> login(String email, String password) async {
    final UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<User> register(String email, String password) async {
    final UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<User> getLoggedUser() async {
    User user = _auth.currentUser;
    if (user != null) {
      try {
        await user.reload();
      } catch (e) {
        return null;
      }
      user = _auth.currentUser;
      if (user == null) {
        return null;
      }
      return user;
    }
    return null;
  }

  Future<void> logout() async {
    return _auth.signOut();
  }
}
