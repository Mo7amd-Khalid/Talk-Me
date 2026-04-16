import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/data/models/notification_dto.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';
import 'package:talk_me/presentation/bottom_nav_bar/users/cubit/users_contract.dart';
import 'package:talk_me/presentation/main/cubit/main_contract.dart';
import 'package:talk_me/presentation/main/cubit/main_cubit.dart';
import '../../../../core/utils/resources.dart';

@injectable
class UsersCubit extends BaseCubit<UsersState, UsersActions, UsersNavigation> {
  UsersCubit(this._repositoryContract, this._mainCubit) : super(UsersState());

  final RepositoryContract _repositoryContract;
  final MainCubit _mainCubit;

  @override
  Future<void> doAction(UsersActions action) async {
    switch (action) {
      case GetUsers():
        _getUsers(action.myData);
      case SendAddRequest():
        _sendAddRequest(action.myData, action.friendID);
      case RemoveAddRequest():
        _removeAddRequest(action.myData, action.friendID);
      case AcceptAddRequest():
        _acceptAddRequest(action.myData, action.friendID);
    }
  }

  void _getUsers(UserDm myData) async {
    emit(state.copyWith(users: const Resources.loading()));
    var response = await _repositoryContract.getUsers(myData);

    switch (response) {
      case Success<List<UserDm>>():
        emit(state.copyWith(users: Resources.success(data: response.data)));
      case Failure<List<UserDm>>():
        emit(
          state.copyWith(
            users: Resources.failure(
              exception: response.exception,
              message: response.message,
            ),
          ),
        );
    }
  }

  void _sendAddRequest(UserDm myData, UserDm friendData) async {
    var response = await _repositoryContract.sendAddRequest(
      myData,
      friendData,
    );
    switch (response) {
      case Success<void>():
        _mainCubit.doAction(GetCurrentUserData());
      case Failure<void>():
        emit(
          state.copyWith(
            users: Resources.failure(
              exception: response.exception,
              message: response.message,
            ),
          ),
        );
    }
  }

  void _removeAddRequest(UserDm myData, UserDm friendData) async {
    var response = await _repositoryContract.removeAddRequest(myData, friendData);
    switch (response) {
      case Success<void>():
        _mainCubit.doAction(GetCurrentUserData());
      case Failure<void>():
        emit(
          state.copyWith(
            users: Resources.failure(
              exception: response.exception,
              message: response.message,
            ),
          ),
        );
    }
  }

  void _acceptAddRequest(UserDm myData, UserDm friendData) async {
    var response = await _repositoryContract.acceptAddRequest(
      myData,
      friendData,
    );
    switch (response) {
      case Success<void>():
        _mainCubit.doAction(GetCurrentUserData());
        List<UserDm> newUser = state.users.data!;
        newUser.removeWhere((UserDm user) => user.id == friendData.id);
        emit(state.copyWith(users: Resources.success(data: newUser)));
      case Failure<void>():
        emit(
          state.copyWith(
            users: Resources.failure(
              exception: response.exception,
              message: response.message,
            ),
          ),
        );
    }
  }
}
