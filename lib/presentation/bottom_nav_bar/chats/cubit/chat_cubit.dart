import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';
import 'package:talk_me/presentation/bottom_nav_bar/chats/cubit/chat_contract.dart';

@injectable
class ChatCubit extends BaseCubit<ChatState, ChatActions, ChatNavigation>{
  ChatCubit(this._repositoryContract) : super(ChatState());

  final RepositoryContract _repositoryContract;


  @override
  Future<void> doAction(ChatActions action) async{
    switch(action) {
      case GetFriends():
        _getFriends(action.myData);
      case GoToChatScreen():
        _goToChatScreen(action.friendData);
    }
  }

  void _getFriends(UserDm myData) async{
    emit(state.copyWith(friends: const Resources.loading()));
    var response = await _repositoryContract.getFriends(myData);
    switch(response) {
      case Success<List<UserDm>>():
        emit(state.copyWith(friends: Resources.success(data: response.data)));
      case Failure<List<UserDm>>():
        emit(state.copyWith(friends: Resources.failure(exception: response.exception, message: response.message)));
    }
  }

  void _goToChatScreen(UserDm friedData) {
    emitNavigation(NavigateToChatScreen(friedData));
  }
}