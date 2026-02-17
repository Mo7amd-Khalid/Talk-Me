import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:talk_me/data/network/results.dart';
import '../../core/constant/app_exceptions.dart';
import '../../domain/mapper/app_exception_mapper.dart';

Future<Results<T>> safeCall<T>(Future<Results<T>> Function() call)async{
  try{
    return await call();
  }
  on FirebaseAuthException catch (e, stackTrace) {
    if (kDebugMode) {
      print(stackTrace.toString());
    }
    return Failure(
      exception: AppExceptionMapper.filterFirebaseAuthException(e),
      message: AppExceptionMapper.filterFirebaseAuthException(e).message,
    );
  } on FirebaseException catch (e, stackTrace) {
    if (kDebugMode) {
      print(stackTrace.toString());
    }
    return Failure(
      exception: AppExceptionMapper.filterFirestoreException(e),
      message: AppExceptionMapper.filterFirestoreException(e).message,
    );
  } on SocketException catch (e, stackTrace) {
    if(kDebugMode)
    {
      print(stackTrace.toString());
    }
    return Failure(
      exception: NetworkException(),
      message: NetworkException().message,
    );
  } on IOException catch (e, stackTrace) {
    return Failure(exception: e, message: stackTrace.toString());
  } on TimeoutException catch (e, stackTrace) {
    if(kDebugMode)
    {
      print(stackTrace.toString());
    }
    return Failure(
      exception: TimeLimitException(),
      message: TimeLimitException().message,
    );
  } on FormatException catch (e, stackTrace) {
    if(kDebugMode)
    {
      print(stackTrace.toString());
    }
    return Failure(
      exception: FormatCodeException(),
      message: FormatCodeException().message,
    );
  } catch (e, stackTrace) {
    if(kDebugMode)
    {
      print(stackTrace.toString());
    }
    return Failure(
      exception: UnknownException(),
      message: UnknownException().message,
    );
  }
}