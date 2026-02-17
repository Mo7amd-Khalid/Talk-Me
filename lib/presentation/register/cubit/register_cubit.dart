import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/auth_repository.dart';
import 'package:talk_me/presentation/register/cubit/register_contract.dart';

@injectable
class RegisterCubit extends BaseCubit<RegisterState, RegisterActions, RegisterNavigation>{
  RegisterCubit(this._authRepository) : super(RegisterState());

  final AuthRepository _authRepository;

  @override
  Future<void> doAction(RegisterActions action) async{
    switch(action)
        {
      case RegistrationProcess():
        _registrationProcess(action.name, action.email, action.image, action.password);
      case ResetEmailVerification():
        _resendEmailVerification();
      case ShowImagePicker():
        _showImagePicker();
      case ChangePasswordVisibility():
        _changePasswordVisibility();
      case ChangeRePasswordVisibility():
        _changeRePasswordVisibility();
      case GoToLoginScreen():
        _goToLoginScreen();
    }
  }

  void _registrationProcess(String name, String email, String image, String password) async{
    emitNavigation(ShowLoadingDialog());
    var response = await _authRepository.register(name, image, email, password);
    switch(response) {
      case Success<UserCredential>():
        emitNavigation(ShowSuccessDialog());
      case Failure<UserCredential>():
        emitNavigation(ShowErrorDialog(message: response.message!));
    }
  }

  void _resendEmailVerification() async{
    await _authRepository.sendEmailVerification();
  }

  void _showImagePicker() async{
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null)
      {
        emit(state.copyWith(image: pickedImage.path));
      }
  }

  void _changePasswordVisibility() {
    emit(state.copyWith(passwordObscure: !state.passwordObscure));
  }

  void _changeRePasswordVisibility() {
    emit(state.copyWith(rePasswordObscure: !state.rePasswordObscure));
  }

  void _goToLoginScreen() {
    emitNavigation(NavigateToLoginScreen());
  }


}