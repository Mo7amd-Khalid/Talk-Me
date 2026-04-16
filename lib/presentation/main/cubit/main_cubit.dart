import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/core/constant/app_constant.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';
import 'package:talk_me/presentation/main/cubit/main_contract.dart';

@singleton
class MainCubit extends BaseCubit<MainState, MainActions, MainNavigation>{

  MainCubit(this._repo, this._preferences) : super(MainState());

  final RepositoryContract _repo;
  final SharedPreferences _preferences;

  @override
  Future<void> doAction(MainActions action) async{
    switch (action) {

      case GetCurrentUserData():
        _getCurrentUserData();
      case ChangeCurrentIndex():
        _changeCurrentIndex(action.index);
      case RefreshFCMToken():
        _refreshFCMToken();
    }
  }

  void _getCurrentUserData() async{
    String uid = _preferences.getString(AppKeysConstant.loginKey) ?? "";

    var response = await _repo.getMyUserData(uid);
    switch(response) {
      case Success<UserDm>():
        emit(state.copyWith(currentUser: Resources.success(data: response.data, message: response.message)));
      case Failure<UserDm>():
        emit(state.copyWith(currentUser: Resources.failure(exception: response.exception,message: response.message)));
    }

  }

  void _changeCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void _refreshFCMToken() async{
    String uId = _preferences.getString(AppKeysConstant.loginKey) ?? "";
    var response = await _repo.refreshFCMToken(uId);
    switch (response) {
      case Success<void>():
        print(response.message);
      case Failure<void>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

}