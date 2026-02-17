class RegisterState {
  String image;
  bool passwordObscure;
  bool rePasswordObscure;

  RegisterState({
    this.image = "",
    this.passwordObscure = true,
    this.rePasswordObscure = true,
  });

  RegisterState copyWith({
    String? image,
    bool? passwordObscure,
    bool? rePasswordObscure,
  }) {
    return RegisterState(
      image: image ?? this.image,
      passwordObscure: passwordObscure ?? this.passwordObscure,
      rePasswordObscure: rePasswordObscure ?? this.rePasswordObscure,
    );
  }
}

sealed class RegisterActions {}

class ShowImagePicker extends RegisterActions {}

class RegistrationProcess extends RegisterActions {
  final String name;
  final String email;
  final String image;
  final String password;

  RegistrationProcess({
    required this.name,
    required this.email,
    required this.image,
    required this.password,
  });
}

class ResetEmailVerification extends RegisterActions {}

class ChangePasswordVisibility extends RegisterActions{}

class ChangeRePasswordVisibility extends RegisterActions{}

class GoToLoginScreen extends RegisterActions{}



sealed class RegisterNavigation {}

class ShowLoadingDialog extends RegisterNavigation {}

class ShowSuccessDialog extends RegisterNavigation {}

class ShowErrorDialog extends RegisterNavigation {
  final String message;

  ShowErrorDialog({required this.message});
}

class NavigateToLoginScreen extends RegisterNavigation {}


