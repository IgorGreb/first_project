import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Не вдалося увійти';
    } catch (_) {
      return 'Сталася помилка під час входу';
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Не вдалося створити користувача';
    } catch (_) {
      return 'Сталася помилка під час реєстрації';
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? 'Не вдалося надіслати лист';
    } catch (_) {
      return 'Сталася помилка під час відновлення доступу';
    }
  }

  Future<void> signOut() => _firebaseAuth.signOut();
}
