import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Connect with Your World'**
  String get onboardingTitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Real-Time Conversations'**
  String get onboardingTitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Safe and Secure'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDescription1.
  ///
  /// In en, this message translates to:
  /// **'Join vibrant communities and stay in touch with your friends and family, no matter where they are.'**
  String get onboardingDescription1;

  /// No description provided for @onboardingDescription2.
  ///
  /// In en, this message translates to:
  /// **'Experience lightning-fast messaging with intuitive features designed to keep your conversations flowing.'**
  String get onboardingDescription2;

  /// No description provided for @onboardingDescription3.
  ///
  /// In en, this message translates to:
  /// **'Your privacy is our priority. Chat with peace of mind knowing your data is protected.'**
  String get onboardingDescription3;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @notVerifiedEmailException.
  ///
  /// In en, this message translates to:
  /// **'Email is not verified'**
  String get notVerifiedEmailException;

  /// No description provided for @invalidCredentialsException.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidCredentialsException;

  /// No description provided for @userNotFoundException.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFoundException;

  /// No description provided for @networkException.
  ///
  /// In en, this message translates to:
  /// **'Network error occurred'**
  String get networkException;

  /// No description provided for @unknownException.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, try again'**
  String get unknownException;

  /// No description provided for @sharedPreferencesException.
  ///
  /// In en, this message translates to:
  /// **'Shared preferences error'**
  String get sharedPreferencesException;

  /// No description provided for @registerException.
  ///
  /// In en, this message translates to:
  /// **'The email address is already in use by another account'**
  String get registerException;

  /// No description provided for @timeLimitException.
  ///
  /// In en, this message translates to:
  /// **'Time limit exceeded'**
  String get timeLimitException;

  /// No description provided for @formatCodeException.
  ///
  /// In en, this message translates to:
  /// **'Format code error'**
  String get formatCodeException;

  /// No description provided for @permissionDeniedException.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to perform this action'**
  String get permissionDeniedException;

  /// No description provided for @documentNotFoundException.
  ///
  /// In en, this message translates to:
  /// **'Requested document was not found'**
  String get documentNotFoundException;

  /// No description provided for @alreadyExistsException.
  ///
  /// In en, this message translates to:
  /// **'Document already exists'**
  String get alreadyExistsException;

  /// No description provided for @unauthenticatedException.
  ///
  /// In en, this message translates to:
  /// **'User is not authenticated'**
  String get unauthenticatedException;

  /// No description provided for @deadlineExceededException.
  ///
  /// In en, this message translates to:
  /// **'Request timed out, try again'**
  String get deadlineExceededException;

  /// No description provided for @resourceExhaustedException.
  ///
  /// In en, this message translates to:
  /// **'Quota exceeded or resource exhausted'**
  String get resourceExhaustedException;

  /// No description provided for @unavailableException.
  ///
  /// In en, this message translates to:
  /// **'Service is currently unavailable'**
  String get unavailableException;

  /// No description provided for @cancelledException.
  ///
  /// In en, this message translates to:
  /// **'Operation was cancelled'**
  String get cancelledException;

  /// No description provided for @invalidArgumentException.
  ///
  /// In en, this message translates to:
  /// **'Invalid data was provided'**
  String get invalidArgumentException;

  /// No description provided for @dataLossException.
  ///
  /// In en, this message translates to:
  /// **'Data loss occurred'**
  String get dataLossException;

  /// No description provided for @unknownFirestoreException.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again'**
  String get unknownFirestoreException;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @doNotHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get doNotHaveAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @rePassword.
  ///
  /// In en, this message translates to:
  /// **'Re-Password'**
  String get rePassword;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @nameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid name (at least 3 letters)'**
  String get nameInvalid;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character as @, \$, !, %, *, ?, &, #'**
  String get passwordInvalid;

  /// No description provided for @rePasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Re Password Required'**
  String get rePasswordRequired;

  /// No description provided for @rePasswordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Password doesn`t match'**
  String get rePasswordInvalid;

  /// No description provided for @passwordConfirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get passwordConfirmRequired;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @titleEventRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleEventRequired;

  /// No description provided for @descriptionEventRequired.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get descriptionEventRequired;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @emailVerificationMessage.
  ///
  /// In en, this message translates to:
  /// **'We will send a verification email to your email address. Please check your inbox or spam folder and verify your account. You cannot register with this email again if you do not complete the verification process.'**
  String get emailVerificationMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @resendVerificationEmail.
  ///
  /// In en, this message translates to:
  /// **'Re-send verification email'**
  String get resendVerificationEmail;

  /// No description provided for @verificationMessage.
  ///
  /// In en, this message translates to:
  /// **'Verification Message'**
  String get verificationMessage;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error!'**
  String get error;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @sendResetPasswordEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Password Email'**
  String get sendResetPasswordEmail;

  /// No description provided for @resetPasswordEmailSent.
  ///
  /// In en, this message translates to:
  /// **'We sent you an email to reset your password. Please check your inbox or spam folder and follow the instructions.'**
  String get resetPasswordEmailSent;

  /// No description provided for @emailSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Email has been sent successfully'**
  String get emailSentSuccessfully;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
