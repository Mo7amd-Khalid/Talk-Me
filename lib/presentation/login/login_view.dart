import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_me/core/constant/app_assets.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/theme/app_colors.dart';
import 'package:talk_me/core/utils/context_func.dart';
import 'package:talk_me/core/utils/white_spaces.dart';
import 'package:talk_me/core/validation/data_validation.dart';
import 'package:talk_me/presentation/login/cubit/login_contract.dart';
import 'package:talk_me/presentation/login/cubit/login_cubit.dart';
import 'package:talk_me/presentation/widgets/app_dialogs.dart';
import 'package:talk_me/presentation/widgets/language_switch.dart';
import '../../core/routes/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginCubit loginCubit = getIt();

  @override
  void initState() {
    super.initState();
    loginCubit.navigation.listen((navigationState) {
      switch (navigationState) {
        case NavigateToRegisterScreen():
          Navigator.pushNamed(context, Routes.registerView);
        case ShowLoadingDialog():
          AppDialogs.loadingDialog(
            context: context,
            loadingMessage: context.locale!.loading,
          );
        case ShowErrorDialog():
          Navigator.pop(context);
          AppDialogs.actionDialog(
            dismissable: false,
            title: context.locale!.error,
            context: context,
            content: navigationState.message,
            posActionTitle: context.locale!.tryAgain,
          );
        case NavigateToMainScreen():
          Navigator.pushReplacementNamed(context, Routes.mainViews);
        case NavigateToForgetPasswordScreen():
          Navigator.pushNamed(context, Routes.forgetPasswordViews);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginCubit,
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (_, state) => Scaffold(
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
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: state.obscurePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => DataValidation.passwordValidation(
                          value ?? "",
                          context.locale!,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginCubit.doAction(ChangeObscurePassword());
                            },
                            icon: Icon(
                              state.obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          hintText: context.locale!.password,
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  loginCubit.doAction(
                                    LoginProcess(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              child: Text(context.locale!.login),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              loginCubit.doAction(GoToForgetPasswordScreen());
                            },
                            child: Text(context.locale!.forgetPassword,textAlign: TextAlign.end,),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.locale!.doNotHaveAccount),
                          TextButton(
                            onPressed: () {
                              loginCubit.doAction(GoToRegisterScreen());
                            },
                            child: Text(context.locale!.registerNow),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      LanguageSwitch(),
                    ],
                  ),
                ).fadeInUpBig(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
