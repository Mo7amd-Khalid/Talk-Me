import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/context_func.dart';
import 'package:talk_me/core/utils/padding.dart';
import 'package:talk_me/presentation/main/cubit/main_contract.dart';
import 'package:talk_me/presentation/main/cubit/main_cubit.dart';
import 'package:talk_me/presentation/widgets/language_switch.dart';
import 'package:talk_me/presentation/widgets/theme_switch.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (_, state) => Column(
        children: [
          Container(
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
                  child: Image.file(
                    height: context.heightSize * 0.14,
                    width: context.widthSize * 0.3,
                    fit: BoxFit.cover,
                    File(state.currentUser.data!.photoURL!),
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        state.currentUser.data!.displayName!,
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
                                  "150",
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
                                  "150",
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
                    Text(
                        "Theme",
                      style: context.textStyle.titleLarge,
                    ),
                    Spacer(),
                    ThemeSwitch(),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
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
              ],
            ).allPadding(16),
          ),
        ],
      ),
    );
  }
}
