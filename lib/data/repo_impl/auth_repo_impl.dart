import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/constant/app_constant.dart';
import 'package:talk_me/core/constant/app_exceptions.dart';
import 'package:talk_me/data/datasource/contract/auth_remote_datasource.dart';
import 'package:talk_me/data/datasource/contract/firestore_remote_datasource.dart';
import 'package:talk_me/data/datasource/contract/local_datasource.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/auth_repository.dart';
import '../../domain/mapper/app_exception_mapper.dart';

@Injectable(as: AuthRepository)
class AuthRepoImpl implements AuthRepository {
  AuthRepoImpl(
    this._authRemoteDatasource,
    this._firestoreRemoteDatasource,
    this._localDatasource,
  );

  final AuthRemoteDatasource _authRemoteDatasource;
  final FirestoreRemoteDatasource _firestoreRemoteDatasource;
  final LocalDatasource _localDatasource;

  @override
  Future<Results<UserCredential>> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    var response = await _authRemoteDatasource.login(email, password);
    switch (response) {
      case Success<UserCredential>():
        {
          response.data!.user!.reload();
          if (response.data!.user!.emailVerified) {
            _localDatasource.saveDataInSharedPreferences(
              context,
              AppKeysConstant.loginKey,
              response.data!.user!.uid,
            );
            return Success(data: response.data);
          } else {
            await _firestoreRemoteDatasource.removeUserData(
              response.data!.user!.uid,
            );
            await response.data!.user!.delete();
            return Failure(
              exception: NotVerifiedEmailException(),
              message:
                  AppExceptionMapper.convertStringMessageToLocalizationStringMessage(
                    NotVerifiedEmailException(),
                    context,
                  ),
            );
          }
        }
      case Failure<UserCredential>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<UserCredential>> register(
    String name,
    String image,
    String email,
    String password,
  ) async {
    var response = await _authRemoteDatasource.register(
      name,
      image,
      email,
      password,
    );
    switch (response) {
      case Success<UserCredential>():
        {
          await sendEmailVerification();
          UserDm user = UserDm(
            id: response.data!.user!.uid,
            name: name,
            email: email,
            image: image,
            sentRequest: [],
            receivedRequest: [],
            friendsIds: [],
          );
          response.data!.user?.updatePhotoURL(image);
          response.data!.user?.updateDisplayName(name);
          await _firestoreRemoteDatasource.setUserData(user);
          return Success(data: response.data);
        }
      case Failure<UserCredential>():
        return Failure(
          exception: response.exception,
          message: response.message,
        );
    }
  }

  @override
  Future<Results<void>> sendEmailVerification() async {
    var response = await _authRemoteDatasource.sendEmailVerification();
    switch (response) {
      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure(
          exception: response.exception,
          message: response.message,
        );
    }
  }

  @override
  Future<Results<void>> sendResetPasswordEmail(String email, BuildContext context) async{
    var response = await _firestoreRemoteDatasource.checkIfUserExists(email, context);
    switch(response) {
      case Success<bool>():
        await _authRemoteDatasource.sendResetPasswordEmail(email);
        return Success();
      case Failure<bool>():
        return Failure(exception: response.exception, message: response.message);
    }
  }


  @override
  Future<Results<void>> logout(BuildContext context) async{
    var response = await _authRemoteDatasource.logout();
    switch(response) {
      case Success<void>():
        await _localDatasource.saveDataInSharedPreferences(context, AppKeysConstant.loginKey, "");
        return Success();
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }
  }
}
