import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/network/results.dart';

abstract class AuthRepository {
  Future<Results<UserCredential>> register(String name,String image, String email, String password);
  Future<Results<UserCredential>> login(BuildContext context,String email, String password);
  Future<Results<User>> getCurrentUserData();
  Future<Results<void>> sendEmailVerification();
  Future<Results<void>> sendResetPasswordEmail(String email, BuildContext context);
}