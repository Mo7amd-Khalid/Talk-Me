import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/routes/routes.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/context_func.dart';
import 'package:talk_me/core/utils/padding.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/presentation/bottom_nav_bar/settings/cubit/settings_contract.dart';
import 'package:talk_me/presentation/bottom_nav_bar/settings/cubit/settings_cubit.dart';
import 'package:talk_me/presentation/main/cubit/main_contract.dart';
import 'package:talk_me/presentation/main/cubit/main_cubit.dart';
import 'package:talk_me/presentation/widgets/app_dialogs.dart';
import 'package:talk_me/presentation/widgets/language_switch.dart';
import 'package:talk_me/presentation/widgets/profile_widget.dart';
import 'package:talk_me/presentation/widgets/theme_switch.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsCubit _settingsCubit = getIt();

  @override
  void initState() {
    super.initState();
    _settingsCubit.navigation.listen((state) {
      switch (state) {
        case ShowAlertingDialog():
          AppDialogs.actionDialog(
            context: context,
            title: context.locale!.logout,
            content: "Are you sure you want to logout?",
            posActionTitle: "Yes",
            posAction: () {
              _settingsCubit.doAction(Logout(context));
            },
            negActionTitle: "No",
          );
        case NavigateToLoginScreen():
          Navigator.pushReplacementNamed(context, Routes.loginView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<MainCubit, MainState>(
          builder: (_, state) {
            switch(state.currentUser.state) {
              case States.initial:
              case States.loading:
                return Center(child: CircularProgressIndicator(),);
              case States.success:
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  height: context.heightSize * 0.27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: AppColors.blue500,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 10,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: buildProfileImage(
                            path: state.currentUser.data!.image,
                            context: context,
                            height: context.heightSize * 0.14,
                            width: context.widthSize * 0.3,
                            color: AppColors.white
                        ),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              state.currentUser.data!.name,
                              style: context.textStyle.titleLarge!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        context.locale!.friends,
                                        style: context.textStyle.bodyMedium!.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        state.currentUser.data!.friendsIds.length.toString(),
                                        style: context.textStyle.bodyMedium!.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: context.heightSize * 0.05,
                                  child: VerticalDivider(
                                    color: AppColors.white,
                                    thickness: 2,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        context.locale!.request,
                                        style: context.textStyle.bodyMedium!.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        state.currentUser.data!.sentRequest.length.toString(),
                                        style: context.textStyle.bodyMedium!.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(context.locale!.viewYourProfile),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).slideDown();
              case States.failure:
                return Center(child: Text(state.currentUser.message!),);
            }
          },
        ),
        Expanded(
          child: Column(
            spacing: 20,
            children: [
              Row(
                children: [
                  Text(
                    context.locale!.language,
                    style: context.textStyle.titleLarge,
                  ),
                  Spacer(),
                  LanguageSwitch(),
                ],
              ),
              Divider(
                height: 2,
                color: AppColors.black,
                indent: 10,
                endIndent: 10,
                thickness: 2,
              ),
              Row(
                children: [
                  Text("Theme", style: context.textStyle.titleLarge),
                  Spacer(),
                  ThemeSwitch(),
                ],
              ),
              Spacer(),
              BlocProvider.value(
                value: _settingsCubit,
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (_, state) => Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            _settingsCubit.doAction(LogoutConfirmation());
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.red600,
                          ),
                          child: Row(
                            spacing: 5,
                            children: [
                              Icon(Icons.logout_outlined),
                              Text(context.locale!.logout),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).allPadding(16),
        ),
      ],
    );
  }
}
