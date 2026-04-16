import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/routes/routes.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/core/utils/white_spaces.dart';
import 'package:talk_me/presentation/bottom_nav_bar/chats/cubit/chat_cubit.dart';
import 'package:talk_me/presentation/main/cubit/main_cubit.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/context_func.dart';
import '../../setup_cubit/setup_cubit.dart';
import '../../widgets/profile_widget.dart';
import 'cubit/chat_contract.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final ChatCubit _chatCubit = getIt();
  final MainCubit _mainCubit = getIt();
  final SetupCubit _setupCubit = getIt();


  @override
  void initState() {
    super.initState();
    _chatCubit.doAction(GetFriends(_mainCubit.state.currentUser.data!));
    _chatCubit.navigation.listen((state){
      switch(state) {
        case NavigateToChatScreen():
          Navigator.pushNamed(context, Routes.chatScreenViews,arguments: state.friendData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatCubit,
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (_, state) {
          switch(state.friends.state) {
            case States.initial:
            case States.loading:
            return ListView.separated(
              padding: EdgeInsets.all(16),
              itemBuilder: (_, index) => Shimmer(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gray50,
                    AppColors.gray200,
                    AppColors.gray300,
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: _setupCubit.state.mode == ThemeMode.dark
                        ? AppColors.gray600
                        : AppColors.white,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                      ),
                      5.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "",
                              style: context.textStyle.titleMedium!.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            5.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (_, _) => 10.verticalSpace,
              itemCount: 10,
            );
            case States.success:
              return ListView.separated(
                padding: EdgeInsets.all(16),
                  itemBuilder: (_, index) => Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: _setupCubit.state.mode == ThemeMode.dark
                          ? AppColors.gray600
                          : AppColors.white,
                    ),
                    child: InkWell(
                      onTap: (){
                        _chatCubit.doAction(GoToChatScreen(state.friends.data![index]));
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: state.friends.data![index].image.isNotEmpty
                                ? buildProfileImage(
                              path: state.friends.data![index].image,
                              context: context,
                              height: context.heightSize * 0.1,
                              width: context.widthSize * 0.22,
                              color: AppColors.blue500,
                            )
                                : CircularProgressIndicator(),
                          ),
                          5.horizontalSpace,
                          Expanded(
                            child: Text(
                              state.friends.data![index].name,
                              style: context.textStyle.titleMedium!.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_outlined),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (_,_) => 10.verticalSpace,
                  itemCount: state.friends.data!.length);
            case States.failure:
              return Center(child: Text(state.friends.message!),);
          }
        },
      ),
    );
  }
}
