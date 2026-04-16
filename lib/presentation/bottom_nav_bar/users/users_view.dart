import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/context_func.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/core/utils/white_spaces.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/presentation/main/cubit/main_cubit.dart';
import '../../main/cubit/main_contract.dart';
import '../../widgets/user_item.dart';
import 'cubit/users_contract.dart';
import 'cubit/users_cubit.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _PeopleViewState();
}

class _PeopleViewState extends State<UsersView> {
  final UsersCubit _usersCubit = getIt();
  final MainCubit _mainCubit = getIt();

  @override
  void initState() {
    super.initState();
    _mainCubit.doAction(GetCurrentUserData());
    _usersCubit.doAction(GetUsers(_mainCubit.state.currentUser.data!));
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _usersCubit,
      child: BlocBuilder<UsersCubit, UsersState>(
        builder: (_, state) {
          switch (state.users.state) {
            case States.initial:
            case States.loading:
              return ListView.separated(
                padding: EdgeInsets.all(16),
                itemBuilder: (_, index) =>
                    Shimmer(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gray50,
                          AppColors.gray200,
                          AppColors.gray300,
                        ],
                      ),
                      child: UserItem(
                        usersCubit: _usersCubit,
                        user: UserDm(
                          id: "",
                          name: "",
                          email: "",
                          image: "",
                          sentRequest: [],
                          receivedRequest: [],
                          friendsIds: [],
                          fcm: "",
                        ),
                      ),
                    ),
                separatorBuilder: (_, _) => 10.verticalSpace,
                itemCount: 10,
              );
            case States.success:
              return RefreshIndicator(
                child: state.users.data!.isEmpty ? Center(
                    child: Text(context.locale!.noItems)) : ListView.separated(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  itemBuilder: (_, index) =>
                      UserItem(
                        usersCubit: _usersCubit,
                        user: state.users.data![index],
                      ),
                  separatorBuilder: (_, _) => 10.verticalSpace,
                  itemCount: state.users.data!.length,
                ), onRefresh: () async {
                _mainCubit.doAction(GetCurrentUserData());
                _usersCubit.doAction(
                    GetUsers(_mainCubit.state.currentUser.data!));
              },);
            case States.failure:
              return Center(child: Text(context.locale!.noItems));
          }
        },
      ),
    );
  }
}
