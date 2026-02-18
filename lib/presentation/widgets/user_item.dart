import 'dart:io';

import 'package:flutter/material.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/white_spaces.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/presentation/setup_cubit/setup_cubit.dart';

import '../../core/di/di.dart';
import '../../core/utils/context_func.dart';

class UserItem extends StatelessWidget {
  UserItem({required this.user, super.key});
  final SetupCubit _setupCubit = getIt();
  final UserDm user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _setupCubit.state.mode == ThemeMode.dark? AppColors.gray600 : AppColors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: user.image.isNotEmpty? Image.file(
              height: context.heightSize * 0.1,
              width: context.widthSize * 0.22,
              fit: BoxFit.cover,
              File(user.image),
            ) : CircularProgressIndicator(),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: context.textStyle.titleMedium!.copyWith(fontSize: 18),
                ),
                5.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 5,
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
                        child: Text(
                          "Add Friend",
                          style: context.textStyle.bodyLarge!.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 18,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 18,
                        ),
                      ),
                        child: Text("Remove")
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
