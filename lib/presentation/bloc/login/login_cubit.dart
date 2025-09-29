import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/exceptions/auth_exceptions.dart';
import '../../../domain/usecases/auth_usecase.dart';
import '../../../utils/validators/validators.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthUseCase _authUseCase;

  LoginCubit({required AuthUseCase authUseCase})
    : _authUseCase = authUseCase,
      super(LoginState());

  void emailChanged(String email) => emit(state.loginEmailChanged(email));

  void passwordChanged(String password) =>
      emit(state.loginPasswordChanged(password));

  Future<void> loginWithEmail() async {
    emit(state.copyWith(status: LoginStatus.loginEmailInProgress));
    try {
      final User? user = await _authUseCase.loginWithEmail(
        email: state.loginEmail.value,
        password: state.loginPassword.value,
      );

      if (user == null) {
        emit(state.copyWith(status: LoginStatus.initial));
      } else {
        final User userProfile = await _authUseCase.getUserProfile(
          uid: user.uid,
          email: user.email!,
        );
        emit(state.copyWith(status: LoginStatus.success, user: userProfile));
      }
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.loginGoogleInProgress));

    try {
      final User? user = await _authUseCase.loginWithGoogle();
      if (user == null) {
        // User canceled Google login
        emit(state.copyWith(status: LoginStatus.initial));
      } else {
        emit(state.copyWith(status: LoginStatus.success, user: user));
      }
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _authUseCase.sendEmailVerification();
      await _authUseCase.logout();
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
