import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/data/network/safeCall.dart';

import '../contract/auth_remote_datasource.dart';

@Injectable(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource{

  AuthRemoteDatasourceImpl(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;


  @override
  Future<Results<UserCredential>> register(String name,String image, String email, String password) {
    return safeCall(()async{
      var response = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return Success(data: response);
    });
  }

  @override
  Future<Results<void>> sendEmailVerification() {
    return safeCall(()async{
      await _firebaseAuth.currentUser!.sendEmailVerification();
      return Success();
    });
  }

  @override
  Future<Results<UserCredential>> login(String email, String password) {
    return safeCall(()async{
      var response = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return Success(data: response);
    });
  }

  @override
  Future<Results<void>> logout() {
    return safeCall(()async{
      await _firebaseAuth.signOut();
      return Success();
    });
  }

  @override
  Future<Results<void>> sendResetPasswordEmail(String email) {
    return safeCall(()async{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return Success();
    });
  }

  @override
  Future<Results<User>> getCurrentUserData() {
    return safeCall(()async{
      var user = _firebaseAuth.currentUser;
      return Success(data: user);
    });
  }

}