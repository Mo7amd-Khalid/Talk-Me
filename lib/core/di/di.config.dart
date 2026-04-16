// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasource/contract/auth_remote_datasource.dart' as _i912;
import '../../data/datasource/contract/fcm_remote_datasource.dart' as _i140;
import '../../data/datasource/contract/firestore_remote_datasource.dart'
    as _i725;
import '../../data/datasource/contract/local_datasource.dart' as _i486;
import '../../data/datasource/impl/auth_remote_datasource_impl.dart' as _i939;
import '../../data/datasource/impl/fcm_remote_datasource_impl.dart' as _i871;
import '../../data/datasource/impl/firestore_remote_datasource_impl.dart'
    as _i665;
import '../../data/datasource/impl/local_datasource_impl.dart' as _i23;
import '../../data/models/user_dm.dart' as _i955;
import '../../data/network/api_client.dart' as _i927;
import '../../data/repo_impl/auth_repo_impl.dart' as _i540;
import '../../data/repo_impl/repo_impl.dart' as _i212;
import '../../domain/repository/auth_repository.dart' as _i614;
import '../../domain/repository/repository_contract.dart' as _i427;
import '../../presentation/bottom_nav_bar/chats/cubit/chat_cubit.dart' as _i928;
import '../../presentation/bottom_nav_bar/settings/cubit/settings_cubit.dart'
    as _i38;
import '../../presentation/bottom_nav_bar/users/cubit/users_cubit.dart'
    as _i501;
import '../../presentation/chat_screen/cubit/chat_screen_cubit.dart' as _i605;
import '../../presentation/forget_password/cubit/forget_password_cubit.dart'
    as _i671;
import '../../presentation/login/cubit/login_cubit.dart' as _i101;
import '../../presentation/main/cubit/main_cubit.dart' as _i671;
import '../../presentation/onboarding/cubit/onboarding_cubit.dart' as _i657;
import '../../presentation/register/cubit/register_cubit.dart' as _i849;
import '../../presentation/setup_cubit/setup_cubit.dart' as _i529;
import 'provide_dio.dart' as _i833;
import 'provide_firebase.dart' as _i743;
import 'provide_sharedPreferences.dart' as _i1041;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final provideSharedPreferences = _$ProvideSharedPreferences();
    final dioModule = _$DioModule();
    final provideFirebase = _$ProvideFirebase();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => provideSharedPreferences.provideShared(),
      preResolve: true,
    );
    gh.singleton<_i529.SetupCubit>(() => _i529.SetupCubit());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i59.FirebaseAuth>(() => provideFirebase.firebaseAuth());
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => provideFirebase.firebaseFirestore(),
    );
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => provideFirebase.messaging(),
    );
    gh.lazySingleton<_i974.CollectionReference<_i955.UserDm>>(
      () => provideFirebase.userFirestore(),
    );
    gh.factory<_i725.FirestoreRemoteDatasource>(
      () => _i665.FirestoreRemoteDatasourceImpl(
        gh<_i974.CollectionReference<_i955.UserDm>>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i927.ApiClient>(() => _i927.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i486.LocalDatasource>(
      () => _i23.LocalDatasourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i912.AuthRemoteDatasource>(
      () => _i939.AuthRemoteDatasourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.factory<_i140.FCMRemoteDatasource>(
      () => _i871.FCMRemoteDatasourceImpl(gh<_i927.ApiClient>()),
    );
    gh.factory<_i427.RepositoryContract>(
      () => _i212.RepoImpl(
        gh<_i486.LocalDatasource>(),
        gh<_i725.FirestoreRemoteDatasource>(),
        gh<_i892.FirebaseMessaging>(),
        gh<_i140.FCMRemoteDatasource>(),
      ),
    );
    gh.singleton<_i671.MainCubit>(
      () => _i671.MainCubit(
        gh<_i427.RepositoryContract>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i614.AuthRepository>(
      () => _i540.AuthRepoImpl(
        gh<_i912.AuthRemoteDatasource>(),
        gh<_i725.FirestoreRemoteDatasource>(),
        gh<_i486.LocalDatasource>(),
        gh<_i892.FirebaseMessaging>(),
      ),
    );
    gh.factory<_i38.SettingsCubit>(
      () => _i38.SettingsCubit(gh<_i614.AuthRepository>()),
    );
    gh.factory<_i671.ForgetPasswordCubit>(
      () => _i671.ForgetPasswordCubit(gh<_i614.AuthRepository>()),
    );
    gh.factory<_i849.RegisterCubit>(
      () => _i849.RegisterCubit(gh<_i614.AuthRepository>()),
    );
    gh.factory<_i605.ChatScreenCubit>(
      () => _i605.ChatScreenCubit(gh<_i427.RepositoryContract>()),
    );
    gh.factory<_i928.ChatCubit>(
      () => _i928.ChatCubit(gh<_i427.RepositoryContract>()),
    );
    gh.factory<_i501.UsersCubit>(
      () => _i501.UsersCubit(
        gh<_i427.RepositoryContract>(),
        gh<_i671.MainCubit>(),
      ),
    );
    gh.factory<_i101.LoginCubit>(
      () => _i101.LoginCubit(
        gh<_i614.AuthRepository>(),
        gh<_i427.RepositoryContract>(),
      ),
    );
    gh.factory<_i657.OnboardingCubit>(
      () => _i657.OnboardingCubit(gh<_i427.RepositoryContract>()),
    );
    return this;
  }
}

class _$ProvideSharedPreferences extends _i1041.ProvideSharedPreferences {}

class _$DioModule extends _i833.DioModule {}

class _$ProvideFirebase extends _i743.ProvideFirebase {}
