import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/colors.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/services/auth_repository.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<String?> _guardedLogin(
    Future<String?> Function({required String email, required String password})
    action,
    String? email,
    String? password,
  ) {
    if (email == null ||
        email.isEmpty ||
        password == null ||
        password.isEmpty) {
      return Future.value(HabitTexts.missingCredentialsError);
    }
    return action(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();

    return FlutterLogin(
      title: HabitTexts.loginTitle,
      userType: LoginUserType.email,
      messages: LoginMessages(
        userHint: HabitTexts.emailHint,
        passwordHint: HabitTexts.passwordHint,
        confirmPasswordHint: HabitTexts.confirmPasswordHint,
        loginButton: HabitTexts.loginButton,
        signupButton: HabitTexts.signupButton,
        forgotPasswordButton: HabitTexts.forgotPasswordButton,
        recoverPasswordIntro: HabitTexts.recoverPasswordIntro,
        recoverPasswordDescription: HabitTexts.recoverPasswordDescription,
        recoverPasswordSuccess: HabitTexts.recoverPasswordSuccess,
      ),
      onLogin:
          (data) =>
              _guardedLogin(authRepository.signIn, data.name, data.password),
      onSignup:
          (data) =>
              _guardedLogin(authRepository.signUp, data.name, data.password),
      onRecoverPassword: (email) {
        if (email.isEmpty) {
          return Future.value(HabitTexts.recoverEmptyEmail);
        }
        return authRepository.resetPassword(email);
      },
      onSubmitAnimationCompleted: () {},
      hideForgotPasswordButton: false,
      theme: LoginTheme(
        primaryColor: Theme.of(context).colorScheme.primary,
        titleStyle: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(color: AppColors.white),
        bodyStyle: const TextStyle(color: AppColors.white70),
      ),
    );
  }
}
