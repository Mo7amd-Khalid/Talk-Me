import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talk_me/core/utils/context_func.dart';

import '../../core/constant/app_exceptions.dart';

abstract class AppExceptionMapper {
  static AppException filterFirebaseAuthException(FirebaseAuthException exception){
    switch (exception.code) {
      case 'user-not-found':
        return const UserNotFoundException();

      case 'wrong-password':
      case 'invalid-credential':
        return const InvalidCredentialsException();

      case 'network-request-failed':
        return const NetworkException();
      case 'email-already-in-use':
        return const RegisterException();

      default:
        return UnknownException();
    }

  }

  static AppException filterFirestoreException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return const PermissionDeniedException();

      case 'not-found':
        return const DocumentNotFoundException();

      case 'already-exists':
        return const AlreadyExistsException();

      case 'unauthenticated':
        return const UnauthenticatedException();

      case 'deadline-exceeded':
        return const DeadlineExceededException();

      case 'resource-exhausted':
        return const ResourceExhaustedException();

      case 'unavailable':
        return const UnavailableException();

      case 'cancelled':
        return const CancelledException();

      case 'invalid-argument':
        return const InvalidArgumentException();

      case 'data-loss':
        return const DataLossException();

      default:
        return const UnknownFirestoreException();
    }
  }

  static String convertStringMessageToLocalizationStringMessage(AppException e, BuildContext context)
  {

    if(e is NotVerifiedEmailException)
      {
        return context.locale!.notVerifiedEmailException;
      }
    else if(e is InvalidCredentialsException)
    {
      return context.locale!.invalidCredentialsException;
    }
    else if(e is UserNotFoundException)
    {
      return context.locale!.userNotFoundException;
    }
    else if(e is NetworkException)
    {
      return context.locale!.networkException;
    }
    else if(e is SharedPreferencesException)
    {
      return context.locale!.sharedPreferencesException;
    }
    else if(e is RegisterException)
    {
      return context.locale!.registerException;
    }
    else if(e is TimeLimitException)
    {
      return context.locale!.timeLimitException;
    }
    else if(e is FormatCodeException)
    {
      return context.locale!.formatCodeException;
    }
    else if(e is PermissionDeniedException)
    {
      return context.locale!.permissionDeniedException;
    }
    else if(e is DocumentNotFoundException)
    {
      return context.locale!.documentNotFoundException;
    }
    else if(e is AlreadyExistsException)
    {
      return context.locale!.alreadyExistsException;
    }
    else if(e is UnauthenticatedException)
    {
      return context.locale!.unauthenticatedException;
    }
    else if(e is DeadlineExceededException)
    {
      return context.locale!.deadlineExceededException;
    }
    else if(e is ResourceExhaustedException)
    {
      return context.locale!.resourceExhaustedException;
    }
    else if(e is UnavailableException)
    {
      return context.locale!.unavailableException;
    }
    else if(e is CancelledException)
    {
      return context.locale!.cancelledException;
    }
    else if(e is InvalidArgumentException)
    {
      return context.locale!.invalidArgumentException;
    }
    else if(e is DataLossException)
    {
      return context.locale!.dataLossException;
    }
    else if(e is UnknownFirestoreException)
    {
      return context.locale!.unknownFirestoreException;
    }
    else
      {
        return context.locale!.unknownException;
      }
  }
}

