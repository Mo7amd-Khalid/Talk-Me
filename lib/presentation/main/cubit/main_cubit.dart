import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/auth_repository.dart';
import 'package:talk_me/presentation/main/cubit/main_contract.dart';

@singleton
class MainCubit extends BaseCubit<MainState, MainActions, MainNavigation>{

  MainCubit(this._authRepository) : super(MainState());

  final AuthRepository _authRepository;

  @override
  Future<void> doAction(MainActions action) async{
    switch (action) {

      case GetCurrentUserData():
        _getCurrentUserData();
      case ChangeCurrentIndex():
        _changeCurrentIndex(action.index);
    }
  }

  void _getCurrentUserData() async{
    emit(state.copyWith(currentUser: const Resources.loading()));

    var response = await _authRepository.getCurrentUserData();
    switch (response) {

      case Success<User>():
        emit(state.copyWith(currentUser: Resources.success(data: response.data, message: response.message)));
      case Failure<User>():
        emit(state.copyWith(currentUser: Resources.failure(exception: response.exception, message: response.message)));
    }
  }

  void _changeCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

}