import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/constant/app_exceptions.dart';
import 'package:talk_me/data/datasource/contract/firestore_remote_datasource.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/data/network/safeCall.dart';
import 'package:talk_me/domain/mapper/app_exception_mapper.dart';

@Injectable(as: FirestoreRemoteDatasource)
class FirestoreRemoteDatasourceImpl implements FirestoreRemoteDatasource {
  FirestoreRemoteDatasourceImpl(this._userFirestore);

  final CollectionReference<UserDm> _userFirestore;

  @override
  Future<Results<void>> setUserData(UserDm user) {
    return safeCall(() async {
      await _userFirestore.doc(user.id).set(user);
      return Success();
    });
  }

  @override
  Future<Results<void>> removeUserData(String userId) {
    return safeCall(() async {
      await _userFirestore.doc(userId).delete();

      return Success();
    });
  }

  @override
  Future<Results<bool>> checkIfUserExists(String email, BuildContext context) {
    return safeCall(() async {
      var response =  await _userFirestore
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if(response.docs.isEmpty)
        {
          return Failure(exception: UserNotFoundException(), message: AppExceptionMapper.convertStringMessageToLocalizationStringMessage(UserNotFoundException(), context));
        }
      return Success(data: true);
    });
  }

  @override
  Future<Results<List<UserDm>>> getUsers() {
    return safeCall(()async{
      var response = await _userFirestore.get();
      List<UserDm> users = response.docs.map((doc) => doc.data()).toList();
      return Success(data: users);
    });
  }
}
