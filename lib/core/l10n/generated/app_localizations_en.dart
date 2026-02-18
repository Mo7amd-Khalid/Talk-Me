// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboardingTitle1 => 'Connect with Your World';

  @override
  String get onboardingTitle2 => 'Real-Time Conversations';

  @override
  String get onboardingTitle3 => 'Safe and Secure';

  @override
  String get onboardingDescription1 =>
      'Join vibrant communities and stay in touch with your friends and family, no matter where they are.';

  @override
  String get onboardingDescription2 =>
      'Experience lightning-fast messaging with intuitive features designed to keep your conversations flowing.';

  @override
  String get onboardingDescription3 =>
      'Your privacy is our priority. Chat with peace of mind knowing your data is protected.';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get Started';

  @override
  String get notVerifiedEmailException => 'Email is not verified';

  @override
  String get invalidCredentialsException => 'Invalid email or password';

  @override
  String get userNotFoundException => 'User not found';

  @override
  String get networkException => 'Network error occurred';

  @override
  String get unknownException => 'Something went wrong, try again';

  @override
  String get sharedPreferencesException => 'Shared preferences error';

  @override
  String get registerException =>
      'The email address is already in use by another account';

  @override
  String get timeLimitException => 'Time limit exceeded';

  @override
  String get formatCodeException => 'Format code error';

  @override
  String get permissionDeniedException =>
      'You don\'t have permission to perform this action';

  @override
  String get documentNotFoundException => 'Requested document was not found';

  @override
  String get alreadyExistsException => 'Document already exists';

  @override
  String get unauthenticatedException => 'User is not authenticated';

  @override
  String get deadlineExceededException => 'Request timed out, try again';

  @override
  String get resourceExhaustedException =>
      'Quota exceeded or resource exhausted';

  @override
  String get unavailableException => 'Service is currently unavailable';

  @override
  String get cancelledException => 'Operation was cancelled';

  @override
  String get invalidArgumentException => 'Invalid data was provided';

  @override
  String get dataLossException => 'Data loss occurred';

  @override
  String get unknownFirestoreException =>
      'Something went wrong, please try again';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgetPassword => 'Forget Password';

  @override
  String get login => 'Login';

  @override
  String get doNotHaveAccount => 'Don\'t have an account?';

  @override
  String get registerNow => 'Register Now';

  @override
  String get name => 'Name';

  @override
  String get rePassword => 'Re-Password';

  @override
  String get register => 'Register';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginNow => 'Login Now';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get nameInvalid => 'Please enter a valid name (at least 3 letters)';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Please enter a valid email address';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordInvalid =>
      'Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character as @, \$, !, %, *, ?, &, #';

  @override
  String get rePasswordRequired => 'Re Password Required';

  @override
  String get rePasswordInvalid => 'Password doesn`t match';

  @override
  String get passwordConfirmRequired => 'Please confirm your password';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get titleEventRequired => 'Title is required';

  @override
  String get descriptionEventRequired => 'Description is required';

  @override
  String get loading => 'Loading...';

  @override
  String get emailVerificationMessage =>
      'We will send a verification email to your email address. Please check your inbox or spam folder and verify your account. You cannot register with this email again if you do not complete the verification process.';

  @override
  String get ok => 'OK';

  @override
  String get resendVerificationEmail => 'Re-send verification email';

  @override
  String get verificationMessage => 'Verification Message';

  @override
  String get error => 'Error!';

  @override
  String get tryAgain => 'Try again';

  @override
  String get sendResetPasswordEmail => 'Send Reset Password Email';

  @override
  String get resetPasswordEmailSent =>
      'We sent you an email to reset your password. Please check your inbox or spam folder and follow the instructions.';

  @override
  String get emailSentSuccessfully => 'Email has been sent successfully';

  @override
  String get addFriend => 'Add Friend';

  @override
  String get remove => 'Remove';

  @override
  String get noItems => 'There are no users to show';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get logout => 'Logout';

  @override
  String get friends => 'Friends';

  @override
  String get request => 'Requests';

  @override
  String get viewYourProfile => 'View Your Profile';
}
