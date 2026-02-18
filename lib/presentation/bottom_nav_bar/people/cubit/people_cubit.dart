import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';
import 'package:talk_me/presentation/bottom_nav_bar/people/cubit/people_contract.dart';

import '../../../../core/utils/resources.dart';

@injectable
class PeopleCubit extends BaseCubit<PeopleState, PeopleActions, PeopleNavigation>{

  PeopleCubit(this._repositoryContract) : super(PeopleState());

  final RepositoryContract _repositoryContract;
  @override
  Future<void> doAction(PeopleActions action) async{
    switch(action) {
      case GetUsers():
        _getUsers(action.uID);
    }
  }

  void _getUsers(String uID) async{
    emit(state.copyWith(users: const Resources.loading()));
    var response = await _repositoryContract.getUsers(uID);
    switch(response) {
      case Success<List<UserDm>>():
        print(response.data!.length);
        emit(state.copyWith(users: Resources.success(data: response.data)));
      case Failure<List<UserDm>>():
        emit(state.copyWith(users: Resources.failure(exception: response.exception, message: response.message)));
    }
  }


}