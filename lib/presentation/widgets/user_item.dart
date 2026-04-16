import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/core/utils/white_spaces.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/presentation/bottom_nav_bar/users/cubit/users_cubit.dart';
import 'package:talk_me/presentation/main/cubit/main_contract.dart';
import 'package:talk_me/presentation/main/cubit/main_cubit.dart';
import 'package:talk_me/presentation/setup_cubit/setup_cubit.dart';
import 'package:talk_me/presentation/widgets/profile_widget.dart';
import '../../core/di/di.dart';
import '../../core/utils/context_func.dart';
import '../bottom_nav_bar/users/cubit/users_contract.dart';

class UserItem extends StatelessWidget {
  UserItem({required this.usersCubit, required this.user, super.key});

  final UsersCubit usersCubit;
  final SetupCubit _setupCubit = getIt();
  final UserDm user;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: user.image.isNotEmpty
                ? buildProfileImage(
                    path: user.image,
                    context: context,
                    height: context.heightSize * 0.1,
                    width: context.widthSize * 0.22,
                    color: AppColors.blue500,
                  )
                : CircularProgressIndicator(),
          ),
          5.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: context.textStyle.titleMedium!.copyWith(fontSize: 18),
                ),
                5.verticalSpace,
                BlocBuilder<MainCubit, MainState>(
                  builder: (_, state) {
                    switch (state.currentUser.state) {
                      case States.initial:
                      case States.loading:
                        return Center(child: CircularProgressIndicator());
                      case States.success:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 5,
                          children: [
                            Expanded(
                              child:
                                  !state.currentUser.data!.sentRequest.contains(
                                    user.id,
                                  )
                                  ? FilledButton(
                                      onPressed: () async {
                                        if (state.currentUser.data!.receivedRequest.contains(user.id)) {
                                          usersCubit.doAction(AcceptAddRequest(state.currentUser.data!, user,),);
                                        } else if(state.currentUser.data!.friendsIds.contains(user.id)){
                                          //todo go to chat screen
                                        }else {
                                          print(state.currentUser.data!.name);
                                          usersCubit.doAction(
                                            SendAddRequest(
                                              state.currentUser.data!,
                                              user,
                                            ),
                                          );
                                        }
                                      },
                                      style: FilledButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 18,
                                        ),
                                      ),
                                      child: Text(
                                        state.currentUser.data!.receivedRequest
                                                .contains(user.id)
                                            ? "Accept"
                                            : state.currentUser.data!.friendsIds
                                                  .contains(user.id)
                                            ? "Friends"
                                            : "Add",
                                        style: context.textStyle.bodyMedium!
                                            .copyWith(color: AppColors.white),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        usersCubit.doAction(
                                          RemoveAddRequest(
                                            state.currentUser.data!,
                                            user,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 18,
                                        ),
                                      ),
                                      child: Text("Cancel"),
                                    ),
                            ),
                            if (state.currentUser.data!.receivedRequest
                                .contains(user.id))
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    usersCubit.doAction(
                                      RemoveAddRequest(
                                        state.currentUser.data!,
                                        user,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 18,
                                    ),
                                  ),
                                  child: Text("Cancel"),
                                ),
                              ),
                          ],
                        );
                      case States.failure:
                        return Center(child: Text(state.currentUser.message!));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
