import 'dart:developer';

import 'package:eatzy/domain/usecases/user_usecase.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../domain/usecases/auth_usecase.dart';
import '../../../utils/validators/validators.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthUseCase _authUseCase;
  final UserUseCase _userUseCase;

  SignupCubit({
    required AuthUseCase authUseCase,
    required UserUseCase userUseCase,
  }) : _authUseCase = authUseCase,
       _userUseCase = userUseCase,
       super(SignupState());

  void fullNameChanged(String fullName) =>
      emit(state.fullNameChanged(fullName));

  void emailChanged(String email) => emit(state.signupEmailChanged(email));

  void passwordChanged(String password) =>
      emit(state.signupPasswordChanged(password));

  void confirmPasswordChanged(String confirmPassword) =>
      emit(state.signupConfirmPasswordChanged(confirmPassword));

  void countryCodeChanged(String? countryCode) =>
      emit(state.countryCodeChanged(countryCode));

  void phoneNumberChanged(String phoneNumber) =>
      emit(state.phoneNumberChanged(phoneNumber));

  void dobChanged(DateTime dob) => emit(state.dobChanged(dob));

  Future<void> signupWithEmail() async {
    emit(state.copyWith(status: SignupStatus.signupEmailInProgress));
    try {
      final User? user = await _authUseCase.signupWithEmail(
        email: state.signupEmail.value,
        password: state.signupPassword.value,
      );

      if (user == null) {
        emit(state.copyWith(status: SignupStatus.initial));
      } else {
        String phoneNumber = '${state.countryCode}-${state.phoneNumber.value}';
        await _userUseCase.saveUserProfile(
          uid: user.uid,
          fullName: state.fullName.value,
          email: state.signupEmail.value,
          dob: state.dob.value!,
          phoneNumber: phoneNumber,
          photoURL: user.photoURL,
        );
        User? userProfile = user.copyWith(
          uid: user.uid,
          name: state.fullName.value,
          email: state.signupEmail.value,
          dob: state.dob.value!,
          phoneNumber: phoneNumber,
          photoURL: user.photoURL,
        );
        emit(state.copyWith(status: SignupStatus.success, user: userProfile));
      }
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(status: SignupStatus.failure, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> signupWithGoogle() async {
    emit(state.copyWith(status: SignupStatus.signupGoogleInProgress));

    try {
      final User? user = await _authUseCase.loginWithGoogle();
      log('User $user');
      if (user == null) {
        // User canceled Google login
        emit(state.copyWith(status: SignupStatus.initial));
      } else {
        emit(state.copyWith(status: SignupStatus.success, user: user));
      }
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(status: SignupStatus.failure, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _authUseCase.sendEmailVerification();
      await _authUseCase.logout();
    } catch (e) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
