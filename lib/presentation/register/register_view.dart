import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_me/core/constant/app_assets.dart';
import 'package:talk_me/core/di/di.dart';
import 'package:talk_me/core/routes/routes.dart';
import 'package:talk_me/presentation/register/cubit/register_contract.dart';
import 'package:talk_me/presentation/register/cubit/register_cubit.dart';
import 'package:talk_me/presentation/widgets/app_dialogs.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/context_func.dart';
import '../../core/utils/white_spaces.dart';
import '../../core/validation/data_validation.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController rePasswordController = TextEditingController();

  RegisterCubit registerCubit = getIt();

  @override
  void initState() {
    super.initState();
    registerCubit.navigation.listen((state){
      switch(state) {
        case ShowLoadingDialog():
          AppDialogs.loadingDialog(context: context, loadingMessage: context.locale!.loading);
        case ShowSuccessDialog():
          AppDialogs.actionDialog(
              context: context,
            title: context.locale!.verificationMessage,
            content: context.locale!.emailVerificationMessage,
            posActionTitle: context.locale!.ok,
            posAction: (){
              registerCubit.doAction(GoToLoginScreen());
            },
            negActionTitle: context.locale!.resendVerificationEmail,
            negAction: (){
                registerCubit.doAction(ResetEmailVerification());
            }
          );
        case ShowErrorDialog():
          Navigator.pop(context);
          AppDialogs.actionDialog(
              context: context,
              content: state.message,
            posActionTitle: context.locale!.tryAgain
          );
        case NavigateToLoginScreen():
          Navigator.pushReplacementNamed(context, Routes.loginView);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: registerCubit,
      child: BlocBuilder<RegisterCubit, RegisterState>(
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
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: state.image.isEmpty
                                  ? Image.asset(
                                AppImages.logo,
                                height: context.heightSize *0.2,
                                width: context.widthSize *0.4,
                                fit: BoxFit.cover,)
                                  : Image.file(
                                File(state.image),
                                height: context.heightSize *0.2,
                                width: context.widthSize *0.4,
                                fit: BoxFit.cover,),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                color: AppColors.gray200,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  registerCubit.doAction(ShowImagePicker());
                                },
                                icon: Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) => DataValidation.nameValidation(
                          value ?? "",
                          context.locale!,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: context.locale!.name,
                        ),
                      ),
                      20.verticalSpace,
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => DataValidation.emailValidation(
                          value ?? "",
                          context.locale!,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: context.locale!.email,
                        ),
                      ),
                      20.verticalSpace,
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: state.passwordObscure,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => DataValidation.passwordValidation(
                          value ?? "",
                          context.locale!,
                        ),
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          prefixIcon: Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              registerCubit.doAction(ChangePasswordVisibility());
                            },
                            icon: Icon(state.passwordObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          ),
                          hintText: context.locale!.password,
                        ),
                      ),
                      20.verticalSpace,
                      TextFormField(
                        controller: rePasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: state.rePasswordObscure,
                        validator: (value) => DataValidation.rePasswordValidation(
                          value ?? "",
                          passwordController.text,
                          context.locale!,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          prefixIcon: Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              registerCubit.doAction(ChangeRePasswordVisibility());
                            },
                            icon: Icon(state.rePasswordObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          ),
                          hintText: context.locale!.rePassword,
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                if(formKey.currentState!.validate())
                                  {
                                    registerCubit.doAction(RegistrationProcess(
                                        name: nameController.text,
                                        email: emailController.text,
                                        image: state.image.isNotEmpty? state.image : AppImages.logo,
                                        password: rePasswordController.text));
                                  }
                              },
                              child: Text(context.locale!.register),
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.locale!.alreadyHaveAccount),
                          TextButton(
                            onPressed: () {
                              registerCubit.doAction(GoToLoginScreen());
                            },
                            child: Text(context.locale!.loginNow),
                          ),
                        ],
                      ),
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
