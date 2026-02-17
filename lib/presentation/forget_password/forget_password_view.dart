import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/routes/routes.dart';
import 'package:talk_me/presentation/forget_password/cubit/forget_password_contract.dart';
import 'package:talk_me/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:talk_me/presentation/widgets/app_dialogs.dart';

import '../../core/constant/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';
import '../../core/utils/white_spaces.dart';
import '../../core/validation/data_validation.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final ForgetPasswordCubit _forgetPasswordCubit = getIt();

  @override
  void initState() {
    super.initState();
    _forgetPasswordCubit.navigation.listen((state){
      switch(state) {
        case ShowSuccessDialog():
          Navigator.pop(context);
          AppDialogs.actionDialog(
            context: context,
            title: context.locale!.emailSentSuccessfully,
            content: context.locale!.resetPasswordEmailSent,
            posActionTitle: context.locale!.ok,
            posAction: (){
              _forgetPasswordCubit.doAction(GoToLoginScreen());
            }
          );
        case ShowLoadingDialog():
          AppDialogs.loadingDialog(context: context, loadingMessage: context.locale!.loading);
        case ShowErrorDialog():
          Navigator.pop(context);
          AppDialogs.actionDialog(
            title: context.locale!.error,
            context: context,
            content: state.message,
            posActionTitle: context.locale!.ok,
          );
        case NavigateToLoginScreen():
          Navigator.pushReplacementNamed(context, Routes.loginView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  Image.asset(
                    AppImages.logo,
                    width: context.widthSize * 0.4,
                    height: context.heightSize * 0.2,
                  ),
                  20.verticalSpace,
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => DataValidation.emailValidation(
                      value ?? "",
                      context.locale!,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: context.locale!.email,
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _forgetPasswordCubit.doAction(SendForgetPasswordEmail(emailController.text, context));
                            }
                          },
                          child: Text(context.locale!.sendResetPasswordEmail),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).fadeInUpBig(),
          ),
        ),
      ),
    );
  }
}
