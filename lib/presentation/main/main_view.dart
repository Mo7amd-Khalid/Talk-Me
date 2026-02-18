import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/padding.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/core/utils/white_spaces.dart';
import 'package:talk_me/presentation/main/cubit/main_cubit.dart';
import 'package:talk_me/presentation/setup_cubit/setup_contract.dart';
import 'package:talk_me/presentation/setup_cubit/setup_cubit.dart';

import '../../core/utils/context_func.dart';
import 'cubit/main_contract.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MainCubit _mainCubit = getIt();
  final SetupCubit _setupCubit = getIt();

  @override
  void initState() {
    super.initState();
    _mainCubit.doAction(GetCurrentUserData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _mainCubit,
      child: BlocBuilder<MainCubit, MainState>(
        builder: (_, state) => Scaffold(
          appBar: state.currentIndex == 3 ? null : AppBar(
            title: state.currentUser.state == States.success
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          //todo go to profile screen
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: state.currentUser.state == States.success
                              ? Image.file(
                                  height: context.heightSize * 0.06,
                                  File(state.currentUser.data!.photoURL!),
                                  width: context.widthSize * 0.14,
                                  fit: BoxFit.cover,
                                )
                              : CircularProgressIndicator(),
                        ),
                      ),
                      10.horizontalSpace,
                      Text(
                        state.currentUser.data!.displayName!.split(" ")[0],
                        style: context.textStyle.titleLarge!.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  )
                : CircularProgressIndicator(),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
              //Change Theme
              IconButton(
                onPressed: () {
                  _setupCubit.doAction(ChangeMode(_setupCubit.state.mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark));
                },
                icon: Icon(_setupCubit.state.mode == ThemeMode.dark? Icons.light_mode_outlined : Icons.dark_mode_outlined),
              ),
              //Change Language
              5.horizontalSpace,
              InkWell(
                onTap: (){
                  _setupCubit.doAction(ChangeLanguage(_setupCubit.state.language == 'en' ? "ar" : "en"));
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.white,
                  ),
                  child: Text(
                    _setupCubit.state.language.toUpperCase(),
                    style: context.textStyle.bodyMedium!.copyWith(
                      color: AppColors.blue500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
            ],
          ),
          body: state.pages[state.currentIndex],
          bottomNavigationBar: SafeArea(
            bottom: true,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: state.currentIndex,
                onTap: (index) {
                  _mainCubit.doAction(ChangeCurrentIndex(index));
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(state.currentIndex == 0 ? Icons.home_filled : Icons.home_outlined),
                    label: "",
                    tooltip: "Home"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(state.currentIndex == 1 ? Icons.people_alt : Icons.people_outline),
                    label: "",
                    tooltip: "People may be know"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(state.currentIndex == 2 ? Icons.message_rounded : Icons.message_outlined),
                    label: "",
                    tooltip: "Chats"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(state.currentIndex == 3 ? Icons.settings : Icons.settings_outlined),
                    label: "",
                    tooltip: "Profile"
                  ),
                ],
              ),
            ).horizontalPadding(12),
          ),
        ),
      ),
    );
  }
}
