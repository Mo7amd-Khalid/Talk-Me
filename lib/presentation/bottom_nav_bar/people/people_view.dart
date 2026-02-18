import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/context_func.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/core/utils/white_spaces.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/presentation/bottom_nav_bar/people/cubit/people_contract.dart';
import 'package:talk_me/presentation/bottom_nav_bar/people/cubit/people_cubit.dart';
import 'package:talk_me/presentation/main/cubit/main_cubit.dart';
import '../../widgets/user_item.dart';

class PeopleView extends StatefulWidget {
  const PeopleView({super.key});

  @override
  State<PeopleView> createState() => _PeopleViewState();
}

class _PeopleViewState extends State<PeopleView> {

  final PeopleCubit _peopleCubit = getIt();
  final MainCubit _mainCubit = getIt();
  @override
  void initState() {
    super.initState();
    _peopleCubit.doAction(GetUsers(_mainCubit.state.currentUser.data!.uid));
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _peopleCubit,
      child: BlocBuilder<PeopleCubit, PeopleState>(
        builder: (_,state) {
          switch(state.users.state) {
            case States.initial:
            case States.loading:
              return ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemBuilder: (_,index) => Shimmer(gradient: LinearGradient(colors: [
                    AppColors.gray50,
                    AppColors.gray200,
                    AppColors.gray300,
                  ]), child: UserItem(user: UserDm(
                      id: "",
                      name: "",
                      email: "",
                      image: "",
                      additionRequest: [],
                      friendsIds: []),)),
                  separatorBuilder: (_,_) => 10.verticalSpace,
                  itemCount: 10);
            case States.success:
              if(state.users.data!.isEmpty)
              {
                return Center(child: Text(context.locale!.noItems),);
              }
              return ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemBuilder: (_,index) => UserItem(user: state.users.data![index],),
                  separatorBuilder: (_,_) => 10.verticalSpace,
                  itemCount: state.users.data!.length);
            case States.failure:
              return Center(child: Text(context.locale!.noItems),);
          }

        },
      ),
    );
  }
}
