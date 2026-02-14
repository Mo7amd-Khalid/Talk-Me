import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_me/core/constant/app_assets.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/routes/routes.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/context_func.dart';
import 'package:talk_me/core/utils/padding.dart';
import 'package:talk_me/core/utils/white_spaces.dart';
import 'package:talk_me/data/models/onboarding_model.dart';
import 'package:talk_me/presentation/onboarding/cubit/onboarding_contract.dart';
import 'package:talk_me/presentation/onboarding/cubit/onboarding_cubit.dart';

class OnboardingView extends StatefulWidget {
  OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final OnboardingCubit onboardingCubit = getIt();
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    onboardingCubit.doAction(ChangeCurrentIndex(index: 0));
    onboardingCubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case NavigateToLoginScreen():
          Navigator.pushReplacementNamed(context, Routes.loginView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<OnboardingModel> onboardingList = [
      OnboardingModel(
        id: 0,
        title: context.locale!.onboardingTitle1,
        description: context.locale!.onboardingDescription1,
        image: AppImages.onboarding1,
      ),
      OnboardingModel(
        id: 1,
        title: context.locale!.onboardingTitle2,
        description: context.locale!.onboardingDescription2,
        image: AppImages.onboarding2,
      ),
      OnboardingModel(
        id: 2,
        title: context.locale!.onboardingTitle3,
        description: context.locale!.onboardingDescription3,
        image: AppImages.onboarding3,
      ),
    ];
    return BlocProvider.value(
      value: onboardingCubit,
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (_, state) => Scaffold(
          backgroundColor: AppColors.blue50,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemBuilder: (context, index) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(onboardingList[index].image),
                          20.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                onboardingList[index].title,
                                textAlign: TextAlign.center,
                                style: context.textStyle.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          20.verticalSpace,
                          Text(
                            onboardingList[index].description,
                            style: context.textStyle.bodyLarge,
                          ),
                        ],
                      ).allPadding(16),
                    ),
                    itemCount: onboardingList.length,
                    onPageChanged: (index) {
                      onboardingCubit.doAction(
                        ChangeCurrentIndex(index: index),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingList.length,
                    (index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: state.currentIndex == index
                            ? AppColors.blue500
                            : AppColors.white,
                        border: Border.all(width: 1, color: AppColors.blue500),
                      ),
                      width: context.widthSize * 0.09,
                      height: context.heightSize * 0.04,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                50.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          if (state.currentIndex == onboardingList.length - 1) {
                            onboardingCubit.doAction(GoToLoginScreen());
                          } else {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.fastEaseInToSlowEaseOut,
                            );
                            onboardingCubit.doAction(
                              ChangeCurrentIndex(
                                index: _controller.page!.toInt() + 1,
                              ),
                            );
                          }
                        },
                        child: Text(
                          state.currentIndex != onboardingList.length - 1
                              ? context.locale!.next
                              : context.locale!.getStarted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ).allPadding(16),
          ),
        ),
      ),
    );
  }
}
