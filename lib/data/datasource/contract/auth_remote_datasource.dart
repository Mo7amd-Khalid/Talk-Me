import 'package:firebase_auth/firebase_auth.dart';
import 'package:talk_me/data/network/results.dart';

abstract class AuthRemoteDatasource {
  Future<Results<UserCredential>> register(
    String name,
    String image,
    String email,
    String password,
  );
  Future<Results<UserCredential>> login(String email, String password);
  Future<Results<User>> getCurrentUserData();
  Future<Results<void>> sendEmailVerification();
  Future<Results<void>> sendResetPasswordEmail(String email);
  Future<Results<void>> logout();
}
